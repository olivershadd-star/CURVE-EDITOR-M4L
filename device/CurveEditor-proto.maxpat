{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 8,
   "minor": 6,
   "revision": 0,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   100.0,
   100.0,
   900.0,
   600.0
  ],
  "bglocked": 0,
  "openinpresentation": 1,
  "default_fontsize": 12.0,
  "default_fontface": 0,
  "default_fontname": "Arial",
  "gridonopen": 1,
  "gridsize": [
   15.0,
   15.0
  ],
  "gridsnaponopen": 1,
  "objectsnaponopen": 1,
  "statusbarvisible": 2,
  "toolbarvisible": 1,
  "lefttoolbarpinned": 0,
  "toptoolbarpinned": 0,
  "righttoolbarpinned": 0,
  "bottomtoolbarpinned": 0,
  "toolbars_unpinned_last_save": 0,
  "tallnewobj": 0,
  "boxanimatetime": 200,
  "enablehscroll": 1,
  "enablevscroll": 1,
  "devicewidth": 500.0,
  "description": "Curve Editor M4L - lignes de courbes en CC (prototype)",
  "digest": "",
  "tags": "",
  "style": "",
  "subpatcher_template": "",
  "assistshowspatchername": 0,
  "boxes": [
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      20,
      20,
      200.0,
      22.0
     ],
     "text": "midiin",
     "id": "obj-1"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      20,
      70,
      200.0,
      22.0
     ],
     "text": "midiout",
     "id": "obj-2"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      700,
      300,
      200.0,
      22.0
     ],
     "text": "js curve_lanes.js",
     "id": "obj-3"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      700,
      250,
      200.0,
      22.0
     ],
     "text": "qmetro 15 @active 1",
     "id": "obj-4"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 3,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      700,
      400,
      200.0,
      22.0
     ],
     "text": "ctlout",
     "id": "obj-5"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      400,
      20,
      200.0,
      22.0
     ],
     "text": "loadbang",
     "id": "obj-6"
    }
   },
   {
    "box": {
     "maxclass": "live.toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "parameter_enable": 1,
     "patching_rect": [
      100,
      120,
      24.0,
      24.0
     ],
     "presentation": 1,
     "presentation_rect": [
      6.0,
      13.0,
      24.0,
      24.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 On",
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "On",
       "parameter_type": 2,
       "parameter_unitstyle": 0,
       "parameter_enum": [
        "off",
        "on"
       ]
      }
     },
     "varname": "L1_On",
     "id": "obj-7"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      100,
      100,
      60.0,
      20.0
     ],
     "text": "Ligne 1",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      4.0,
      41.0,
      60.0,
      18.0
     ],
     "id": "obj-8"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      200,
      120,
      200.0,
      22.0
     ],
     "text": "prepend lon 0",
     "id": "obj-9"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      200,
      100,
      45.0,
      20.0
     ],
     "text": "CC",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      40.0,
      11.0,
      45.0,
      18.0
     ],
     "id": "obj-10"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      200,
      140,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      40.0,
      29.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        20
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 CC",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "CC",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L1_CC",
     "id": "obj-11"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      200,
      180,
      200.0,
      22.0
     ],
     "text": "prepend lcc 0",
     "id": "obj-12"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      260,
      100,
      45.0,
      20.0
     ],
     "text": "Canal",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      92.0,
      11.0,
      45.0,
      18.0
     ],
     "id": "obj-13"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      260,
      140,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      92.0,
      29.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 Canal",
       "parameter_mmax": 16.0,
       "parameter_mmin": 1.0,
       "parameter_shortname": "Canal",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L1_Canal",
     "id": "obj-14"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      260,
      180,
      200.0,
      22.0
     ],
     "text": "prepend lch 0",
     "id": "obj-15"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      320,
      100,
      45.0,
      20.0
     ],
     "text": "Mes.",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      144.0,
      11.0,
      45.0,
      18.0
     ],
     "id": "obj-16"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      320,
      140,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      144.0,
      29.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 Mesures",
       "parameter_mmax": 16.0,
       "parameter_mmin": 1.0,
       "parameter_shortname": "Mes.",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L1_Mesures",
     "id": "obj-17"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320,
      180,
      200.0,
      22.0
     ],
     "text": "prepend lbars 0",
     "id": "obj-18"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      380,
      100,
      45.0,
      20.0
     ],
     "text": "Min",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      196.0,
      11.0,
      45.0,
      18.0
     ],
     "id": "obj-19"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      380,
      140,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      196.0,
      29.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        0
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 Min",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "Min",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L1_Min",
     "id": "obj-20"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      380,
      180,
      200.0,
      22.0
     ],
     "text": "prepend lmin 0",
     "id": "obj-21"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      440,
      100,
      45.0,
      20.0
     ],
     "text": "Max",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      248.0,
      11.0,
      45.0,
      18.0
     ],
     "id": "obj-22"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      440,
      140,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      248.0,
      29.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        127
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L1 Max",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "Max",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L1_Max",
     "id": "obj-23"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      440,
      180,
      200.0,
      22.0
     ],
     "text": "prepend lmax 0",
     "id": "obj-24"
    }
   },
   {
    "box": {
     "maxclass": "multislider",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "size": 16,
     "setminmax": [
      0.0,
      1.0
     ],
     "setstyle": 1,
     "contdata": 1,
     "patching_rect": [
      500,
      120,
      190.0,
      72.0
     ],
     "presentation": 1,
     "presentation_rect": [
      300.0,
      7.0,
      190.0,
      72.0
     ],
     "varname": "courbe_1",
     "id": "obj-25"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      210,
      200.0,
      22.0
     ],
     "text": "prepend lcurve 0",
     "id": "obj-26"
    }
   },
   {
    "box": {
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      400,
      60,
      300.0,
      22.0
     ],
     "text": "0.5000 0.6913 0.8536 0.9619 1.0000 0.9619 0.8536 0.6913 0.5000 0.3087 0.1464 0.0381 0.0000 0.0381 0.1464 0.3087",
     "id": "obj-27"
    }
   },
   {
    "box": {
     "maxclass": "live.toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "parameter_enable": 1,
     "patching_rect": [
      100,
      210,
      24.0,
      24.0
     ],
     "presentation": 1,
     "presentation_rect": [
      6.0,
      93.0,
      24.0,
      24.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 On",
       "parameter_mmax": 1.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "On",
       "parameter_type": 2,
       "parameter_unitstyle": 0,
       "parameter_enum": [
        "off",
        "on"
       ]
      }
     },
     "varname": "L2_On",
     "id": "obj-28"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      100,
      100,
      60.0,
      20.0
     ],
     "text": "Ligne 2",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      4.0,
      121.0,
      60.0,
      18.0
     ],
     "id": "obj-29"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      200,
      210,
      200.0,
      22.0
     ],
     "text": "prepend lon 1",
     "id": "obj-30"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      200,
      100,
      45.0,
      20.0
     ],
     "text": "CC",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      40.0,
      91.0,
      45.0,
      18.0
     ],
     "id": "obj-31"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      200,
      230,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      40.0,
      109.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        21
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 CC",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "CC",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L2_CC",
     "id": "obj-32"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      200,
      270,
      200.0,
      22.0
     ],
     "text": "prepend lcc 1",
     "id": "obj-33"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      260,
      100,
      45.0,
      20.0
     ],
     "text": "Canal",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      92.0,
      91.0,
      45.0,
      18.0
     ],
     "id": "obj-34"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      260,
      230,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      92.0,
      109.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 Canal",
       "parameter_mmax": 16.0,
       "parameter_mmin": 1.0,
       "parameter_shortname": "Canal",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L2_Canal",
     "id": "obj-35"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      260,
      270,
      200.0,
      22.0
     ],
     "text": "prepend lch 1",
     "id": "obj-36"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      320,
      100,
      45.0,
      20.0
     ],
     "text": "Mes.",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      144.0,
      91.0,
      45.0,
      18.0
     ],
     "id": "obj-37"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      320,
      230,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      144.0,
      109.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        1
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 Mesures",
       "parameter_mmax": 16.0,
       "parameter_mmin": 1.0,
       "parameter_shortname": "Mes.",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L2_Mesures",
     "id": "obj-38"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320,
      270,
      200.0,
      22.0
     ],
     "text": "prepend lbars 1",
     "id": "obj-39"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      380,
      100,
      45.0,
      20.0
     ],
     "text": "Min",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      196.0,
      91.0,
      45.0,
      18.0
     ],
     "id": "obj-40"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      380,
      230,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      196.0,
      109.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        0
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 Min",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "Min",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L2_Min",
     "id": "obj-41"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      380,
      270,
      200.0,
      22.0
     ],
     "text": "prepend lmin 1",
     "id": "obj-42"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      440,
      100,
      45.0,
      20.0
     ],
     "text": "Max",
     "fontsize": 10.0,
     "presentation": 1,
     "presentation_rect": [
      248.0,
      91.0,
      45.0,
      18.0
     ],
     "id": "obj-43"
    }
   },
   {
    "box": {
     "maxclass": "live.numbox",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "patching_rect": [
      440,
      230,
      45.0,
      15.0
     ],
     "presentation": 1,
     "presentation_rect": [
      248.0,
      109.0,
      45.0,
      15.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_initial": [
        127
       ],
       "parameter_initial_enable": 1,
       "parameter_longname": "L2 Max",
       "parameter_mmax": 127.0,
       "parameter_mmin": 0.0,
       "parameter_shortname": "Max",
       "parameter_type": 1,
       "parameter_unitstyle": 0
      }
     },
     "varname": "L2_Max",
     "id": "obj-44"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      440,
      270,
      200.0,
      22.0
     ],
     "text": "prepend lmax 1",
     "id": "obj-45"
    }
   },
   {
    "box": {
     "maxclass": "multislider",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "size": 16,
     "setminmax": [
      0.0,
      1.0
     ],
     "setstyle": 1,
     "contdata": 1,
     "patching_rect": [
      500,
      210,
      190.0,
      72.0
     ],
     "presentation": 1,
     "presentation_rect": [
      300.0,
      87.0,
      190.0,
      72.0
     ],
     "varname": "courbe_2",
     "id": "obj-46"
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      500,
      300,
      200.0,
      22.0
     ],
     "text": "prepend lcurve 1",
     "id": "obj-47"
    }
   },
   {
    "box": {
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      400,
      90,
      300.0,
      22.0
     ],
     "text": "0.0000 0.0667 0.1333 0.2000 0.2667 0.3333 0.4000 0.4667 0.5333 0.6000 0.6667 0.7333 0.8000 0.8667 0.9333 1.0000",
     "id": "obj-48"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-1",
      0
     ],
     "destination": [
      "obj-2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-4",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      0
     ],
     "destination": [
      "obj-5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      1
     ],
     "destination": [
      "obj-5",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      2
     ],
     "destination": [
      "obj-5",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-7",
      0
     ],
     "destination": [
      "obj-9",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
      0
     ],
     "destination": [
      "obj-12",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-12",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-14",
      0
     ],
     "destination": [
      "obj-15",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-15",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-17",
      0
     ],
     "destination": [
      "obj-18",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-18",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
      0
     ],
     "destination": [
      "obj-21",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-21",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-23",
      0
     ],
     "destination": [
      "obj-24",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-24",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25",
      0
     ],
     "destination": [
      "obj-26",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-26",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-27",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-27",
      0
     ],
     "destination": [
      "obj-25",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-28",
      0
     ],
     "destination": [
      "obj-30",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-32",
      0
     ],
     "destination": [
      "obj-33",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-33",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-35",
      0
     ],
     "destination": [
      "obj-36",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-36",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-38",
      0
     ],
     "destination": [
      "obj-39",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-39",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-41",
      0
     ],
     "destination": [
      "obj-42",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-44",
      0
     ],
     "destination": [
      "obj-45",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-45",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-46",
      0
     ],
     "destination": [
      "obj-47",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-47",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-48",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-48",
      0
     ],
     "destination": [
      "obj-46",
      0
     ]
    }
   }
  ]
 }
}
