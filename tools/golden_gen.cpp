// Genere tests/golden.json a partir du code C++ de Curve Mini 0.6 (reference).
// Usage : g++ -std=c++17 -I <dossier Source de Curve Mini> tools/golden_gen.cpp -o /tmp/golden_gen && /tmp/golden_gen > tests/golden.json
// Le fichier golden.json est versionne : les tests JavaScript n'ont pas besoin du C++.
#include "Curve.h"
#include "LaneMath.h"
#include "MotionLanguage.h"
#include <cstdio>
#include <string>
#include <vector>
using namespace std;

static string esc(const string& s) {
    string o = "\"";
    for (unsigned char c : s) {
        if (c == '"') o += "\\\""; else if (c == '\\') o += "\\\\"; else if (c == '\n') o += "\\n";
        else if (c == '\r') o += "\\r"; else if (c == '\t') o += "\\t"; else if (c < 0x20) { char b[8]; snprintf(b, 8, "\\u%04x", c); o += b; }
        else o += (char)c;
    }
    return o + "\"";
}
static string num(double v) { char b[64]; snprintf(b, 64, "%.9g", v); return b; }
static string samples(const curve::Data& d) {
    string o = "[";
    for (int n = 0; n <= curve::resolution; n += 64) { if (n) o += ","; o += num(d.y[(size_t)n]); }
    return o + "]";
}
static bool first = true;
static void item(const string& body) { printf("%s%s\n", first ? "" : ",", body.c_str()); first = false; }

static curve::Data noisy() {
    curve::Data d; d.bars = 4;
    for (int n = 0; n <= curve::resolution; ++n) d.y[(size_t)n] = (float)curve::clamp(.5 + .4 * sin(n * .05) + .3 * sin(n * .77));
    return d;
}
static string pointsJson(const vector<curve::Point>& p) {
    string o = "[";
    for (size_t i = 0; i < p.size(); ++i) { if (i) o += ","; o += "[" + num(p[i].x) + "," + num(p[i].y) + "," + num(p[i].tension) + "," + to_string(p[i].shape) + "]"; }
    return o + "]";
}

int main() {
    printf("[\n");
    vector<string> scripts = {
        "duration: 4 bars\nstart: 20%\nramp to 70% over 2 bars smooth\nhold over 1 bars\nramp to 10% over 1 bars in",
        "duration: 4 bars\nstart: 50%\nwave around 50% depth 20% cycles 4 over 4 bars sine",
        "duration: 2 bars\nstart: 15%\nsaw from 15% to 60% cycles 3 over 2 bars linear",
        "# commentaire\nduration: 3 bars\nstart: 0%\nramp to 100% over 1 bars out # fin\nramp to 0% over 1 bars linear\nhold over 1 bars",
        "ramp to 50% over 4 bars linear",
        "duration: 4 bars\nramp to 50% over 3 bars linear",
        "duration: 4 bars\nramp to 50% over 4 bars wobble",
        "duration: 4 bars\nzigzag",
        "duration: 4 bars\nwave around 90% depth 20% cycles 2 over 4 bars sine",
        "duration: 0 bars\nhold over 1 bars",
        "", "# rien",
        "duration: 4 bars\nstart: 50%\nwave around 40% depth 10% cycles 2 over 4 bars sine",
        "duration: 2 bars\nstart: 15%\nsaw from 15% to 60% cycles 2.5 over 2 bars linear",
        "duration: 4 bars\nramp to 150% over 4 bars linear",
        "duration: 4 bars\nramp to 5x% over 4 bars linear"
    };
    for (auto& s : scripts) {
        try { auto d = curve::parse(s); item("{\"kind\":\"script\",\"input\":" + esc(s) + ",\"ok\":true,\"bars\":" + num(d.bars) + ",\"samples\":" + samples(d) + "}"); }
        catch (const exception& e) { item("{\"kind\":\"script\",\"input\":" + esc(s) + ",\"ok\":false,\"error\":" + esc(e.what()) + "}"); }
    }
    struct T { string text; double bars; float initial; };
    vector<T> texts = {
        {"ouvre sur 2 mesures", 4, .25f}, {"ouvre à fond puis ferme", 4, .25f}, {"ouvre doucement, maintiens 1 mesure, ferme vite", 4, .25f},
        {"ferme de moitié", 4, .5f}, {"oscille autour de 50 % amplitude 10 %", 4, .5f}, {"oscille autour de 60 % 8 cycles", 4, .25f},
        {"dents de scie vers 80 %", 4, .25f}, {"monte rapide puis descend lent", 4, .5f}, {"Ouvre jusqu'à 70%, oscille légèrement", 4, .25f},
        {"maintiens", 2, .5f}, {"ouvre de 3 quarts", 4, .25f}, {"ouvre en 2 temps, ferme", 2, 0.f}, {"oscille 16 fois autour de 50 %", 8, .5f},
        {"ouvre de 50 %", 4, .25f}, {"ferme jusqu'à 20 %, maintiens 4 temps", 4, .5f}, {"ouvre sec puis oscille", 4, 0.f},
        {"bonjour", 4, .5f}, {"oscille", 4, .5f}, {"ouvre rapide lent", 4, .5f}, {"carrée", 4, .5f}, {"ouvre pendant 10 mesures", 4, .5f}, {"", 4, .5f},
        {"ouvre", 0.1, .5f}, {"ouvre", 4, 1.5f}, {"dents de scie", 4, .5f}, {"oscille autour de 50 %", 4, 1.f}, {"ouvre 3", 4, .5f},
        {"Ferme à 10%; ouvre à 90%. Maintiens", 4, .5f}
    };
    for (auto& t : texts) {
        try { auto r = motion::translate(t.text, t.bars, t.initial); item("{\"kind\":\"motion\",\"input\":" + esc(t.text) + ",\"bars\":" + num(t.bars) + ",\"initial\":" + num(t.initial) + ",\"ok\":true,\"script\":" + esc(r.script) + ",\"explanation\":" + esc(r.explanation) + ",\"samples\":" + samples(r.data) + "}"); }
        catch (const exception& e) { item("{\"kind\":\"motion\",\"input\":" + esc(t.text) + ",\"bars\":" + num(t.bars) + ",\"initial\":" + num(t.initial) + ",\"ok\":false,\"error\":" + esc(e.what()) + "}"); }
    }
    for (int s = 0; s <= 5; ++s) item("{\"kind\":\"preset\",\"shape\":" + to_string(s) + ",\"samples\":" + samples(curve::preset(s, 4)) + "}");
    for (unsigned seed : {12345u, 0u, 4294967295u, 7u}) for (float depth : {.2f, .05f}) {
        auto d = curve::vary(curve::preset(0, 4), depth, seed);
        item("{\"kind\":\"vary\",\"seed\":" + to_string(seed) + ",\"depth\":" + num(depth) + ",\"samples\":" + samples(d) + "}");
    }
    for (float st : {.3f, 1.f, 0.f, .05f}) item("{\"kind\":\"smooth\",\"strength\":" + num(st) + ",\"samples\":" + samples(curve::smoothDrawing(noisy(), st)) + "}");
    item("{\"kind\":\"simplify\",\"source\":\"preset0\",\"tolerance\":0.006,\"points\":" + pointsJson(curve::simplify(curve::preset(0, 4), .006)) + "}");
    item("{\"kind\":\"simplify\",\"source\":\"noisy\",\"tolerance\":0.02,\"points\":" + pointsJson(curve::simplify(noisy(), .02)) + "}");
    item("{\"kind\":\"simplify\",\"source\":\"preset5\",\"tolerance\":0.0001,\"points\":" + pointsJson(curve::simplify(curve::preset(5, 4), .0001)) + "}");
    vector<vector<curve::Point>> pointSets = {
        {{0, .2f, .5, 0}, {.3, .9f, -.6, 1}, {.5, .1f, 0, 3}, {.7, .8f, .2, 4}, {1, .4f, 0, 0}},
        {{0, .1f, 0, 0}, {1, .9f, 0, 0}}, {{.5, .5f, 0, 0}}, {{.2, .3f, 1, 6}, {.8, .9f, -1, 5}}
    };
    for (int shape = 0; shape <= 6; ++shape) pointSets.push_back({{0, .1f, .3, shape}, {1, .9f, 0, 0}});
    for (auto& ps : pointSets) {
        auto d = curve::fromPoints(ps, 4);
        item("{\"kind\":\"points\",\"points\":" + pointsJson(ps) + ",\"canonical\":" + pointsJson(curve::canonicalPoints(ps)) + ",\"samples\":" + samples(d) + "}");
    }
    item("{\"kind\":\"canonical\",\"points\":" + pointsJson({{.5, .5f, 0, 0}, {.2, 2.f, 0, 0}, {.5, .7f, .5, 2}, {-1, .3f, 0, 0}, {2, .6f, 2, 9}}) + ",\"canonical\":" +
         pointsJson(curve::canonicalPoints({{.5, .5f, 0, 0}, {.2, 2.f, 0, 0}, {.5, .7f, .5, 2}, {-1, .3f, 0, 0}, {2, .6f, 2, 9}})) + "}");
    auto d0 = curve::preset(0, 4);
    string vals = "[";
    for (double ph : {-.25, 0., .125, .999999, 1., 1.5, 1e-9, -1e-12, 7.3, -3.9}) { if (vals.size() > 1) vals += ","; vals += "[" + num(ph) + "," + num(d0.at(ph)) + "]"; }
    item("{\"kind\":\"at\",\"values\":" + vals + "]}");
    lanemath::Params p; p.min = 10; p.max = 90; p.bars = 2; p.offset = 25; p.depth = 60; p.smooth = 20;
    string tv = "[";
    for (double q : {0., 1.3, 3.9, 8.2, 11.7}) for (double b : {4., 3.}) { if (tv.size() > 1) tv += ","; tv += "[" + num(q) + "," + num(b) + "," + num(lanemath::target(d0, q, b, p)) + "]"; }
    item("{\"kind\":\"target\",\"min\":10,\"max\":90,\"bars\":2,\"offset\":25,\"depth\":60,\"values\":" + tv + "]}");
    float filtered = 0; bool valid = false; string sm = "[";
    for (int i = 0; i < 6; ++i) { float v = lanemath::smooth(filtered, valid, .8f, .01, 20, .3f); if (i) sm += ","; sm += num(v); }
    string sm0 = "[";
    { float f2 = 0; bool v2 = false; for (int i = 0; i < 3; ++i) { float v = lanemath::smooth(f2, v2, .8f, .01, 0, .3f); if (i) sm0 += ","; sm0 += num(v); } }
    item("{\"kind\":\"smoothstep\",\"values\":" + sm + "],\"instant\":" + sm0 + "]}");
    string cc = "[";
    for (float v : {0.f, .5f, .999f, .3937f, 1.f, 1.2f, -.1f, .0039f, .0040f}) { if (cc.size() > 1) cc += ","; cc += "[" + num(v) + "," + to_string(lanemath::toCC(v)) + "]"; }
    item("{\"kind\":\"cc\",\"values\":" + cc + "]}");
    printf("]\n");
}
