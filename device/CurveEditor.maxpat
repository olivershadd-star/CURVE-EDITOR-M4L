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
			60.0,
			80.0,
			1100.0,
			720.0
		],
		"bglocked": 0,
		"openinpresentation": 1,
		"default_fontsize": 10.0,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			5.0,
			5.0
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
		"devicewidth": 1000.0,
		"description": "",
		"digest": "",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						20,
						50,
						22
					],
					"text": "midiin"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						20,
						60,
						55,
						22
					],
					"text": "midiout"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						20,
						200,
						130,
						22
					],
					"text": "js curve_engine.js",
					"varname": "engine"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						20,
						260,
						140,
						22
					],
					"text": "ctlout"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200,
						140,
						70,
						22
					],
					"text": "qmetro 15"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"int",
						"int"
					],
					"patching_rect": [
						330,
						20,
						100,
						22
					],
					"text": "live.thisdevice"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						330,
						50,
						70,
						22
					],
					"text": "delay 300"
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						330,
						80,
						40,
						22
					],
					"text": "t b b"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						380,
						110,
						30,
						22
					],
					"text": "1"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						330,
						110,
						45,
						22
					],
					"text": "ready"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": [
						"dictionary",
						"",
						"",
						""
					],
					"patching_rect": [
						460,
						20,
						100,
						22
					],
					"text": "dict ---state",
					"varname": "state",
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Etat des courbes",
							"parameter_shortname": "Etat",
							"parameter_type": 3
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"bang"
					],
					"patching_rect": [
						460,
						70,
						80,
						22
					],
					"text": "savedialog",
					"varname": "savedlg"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						560,
						70,
						80,
						22
					],
					"text": "opendialog",
					"varname": "opendlg"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						460,
						110,
						120,
						22
					],
					"text": "prepend dialog_path"
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						560,
						110,
						120,
						22
					],
					"text": "prepend dialog_path"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						620,
						150,
						120,
						22
					],
					"text": "dialog_path cancel"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						700,
						20,
						70,
						22
					],
					"text": "r ---cmd"
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "jsui",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						700,
						200,
						300,
						100
					],
					"presentation": 1,
					"presentation_rect": [
						344,
						3,
						652,
						112
					],
					"filename": "curve_ui.js",
					"varname": "editor"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "On",
					"presentation": 1,
					"presentation_rect": [
						22,
						2,
						20,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "CC",
					"presentation": 1,
					"presentation_rect": [
						40,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Ch",
					"presentation": 1,
					"presentation_rect": [
						70,
						2,
						26,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Min",
					"presentation": 1,
					"presentation_rect": [
						94,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Max",
					"presentation": 1,
					"presentation_rect": [
						124,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Mes.",
					"presentation": 1,
					"presentation_rect": [
						154,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Phase",
					"presentation": 1,
					"presentation_rect": [
						184,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Lisse",
					"presentation": 1,
					"presentation_rect": [
						214,
						2,
						34,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Prof.",
					"presentation": 1,
					"presentation_rect": [
						246,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						600,
						20,
						40,
						18
					],
					"text": "Val.",
					"presentation": 1,
					"presentation_rect": [
						276,
						2,
						32,
						14
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"textcolor": [
						0.75,
						0.75,
						0.8,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						320,
						30,
						18
					],
					"text": "1",
					"presentation": 1,
					"presentation_rect": [
						4,
						18,
						16,
						15
					],
					"varname": "sel0",
					"texton": "1",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.26,
						0.87,
						0.74,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						370,
						60,
						22
					],
					"text": "select 0"
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						18,
						16,
						15
					],
					"varname": "p0_on",
					"activebgcolor": [
						0.26,
						0.87,
						0.74,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						430,
						90,
						22
					],
					"text": "prepend p 0 on"
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						18,
						28,
						15
					],
					"varname": "p0_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 cc"
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						18,
						22,
						15
					],
					"varname": "p0_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 channel"
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						18,
						28,
						15
					],
					"varname": "p0_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 min"
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						18,
						28,
						15
					],
					"varname": "p0_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 max"
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						18,
						28,
						15
					],
					"varname": "p0_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 bars"
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						18,
						28,
						15
					],
					"varname": "p0_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 offset"
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						18,
						30,
						15
					],
					"varname": "p0_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 smooth"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						18,
						28,
						15
					],
					"varname": "p0_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 depth"
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						18,
						28,
						15
					],
					"varname": "p0_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						490,
						110,
						22
					],
					"text": "prepend p 0 value"
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						18,
						32,
						15
					],
					"varname": "man0",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						570,
						70,
						22
					],
					"text": "resume 0"
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						320,
						30,
						18
					],
					"text": "2",
					"presentation": 1,
					"presentation_rect": [
						4,
						34,
						16,
						15
					],
					"varname": "sel1",
					"texton": "2",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.41,
						0.71,
						1.0,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						60,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						370,
						60,
						22
					],
					"text": "select 1"
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						34,
						16,
						15
					],
					"varname": "p1_on",
					"activebgcolor": [
						0.41,
						0.71,
						1.0,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						430,
						90,
						22
					],
					"text": "prepend p 1 on"
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						34,
						28,
						15
					],
					"varname": "p1_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								21.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 cc"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						34,
						22,
						15
					],
					"varname": "p1_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 channel"
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						34,
						28,
						15
					],
					"varname": "p1_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 min"
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						34,
						28,
						15
					],
					"varname": "p1_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 max"
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						34,
						28,
						15
					],
					"varname": "p1_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 bars"
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						34,
						28,
						15
					],
					"varname": "p1_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 offset"
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						34,
						30,
						15
					],
					"varname": "p1_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 smooth"
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						34,
						28,
						15
					],
					"varname": "p1_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 depth"
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						34,
						28,
						15
					],
					"varname": "p1_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						490,
						110,
						22
					],
					"text": "prepend p 1 value"
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						60,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						34,
						32,
						15
					],
					"varname": "man1",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						60,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						60,
						570,
						70,
						22
					],
					"text": "resume 1"
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						320,
						30,
						18
					],
					"text": "3",
					"presentation": 1,
					"presentation_rect": [
						4,
						50,
						16,
						15
					],
					"varname": "sel2",
					"texton": "3",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.8,
						0.57,
						1.0,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						100,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						370,
						60,
						22
					],
					"text": "select 2"
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						50,
						16,
						15
					],
					"varname": "p2_on",
					"activebgcolor": [
						0.8,
						0.57,
						1.0,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						430,
						90,
						22
					],
					"text": "prepend p 2 on"
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						50,
						28,
						15
					],
					"varname": "p2_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								22.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 cc"
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						50,
						22,
						15
					],
					"varname": "p2_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 channel"
				}
			},
			{
				"box": {
					"id": "obj-90",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						50,
						28,
						15
					],
					"varname": "p2_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 min"
				}
			},
			{
				"box": {
					"id": "obj-92",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						50,
						28,
						15
					],
					"varname": "p2_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 max"
				}
			},
			{
				"box": {
					"id": "obj-94",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						50,
						28,
						15
					],
					"varname": "p2_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 bars"
				}
			},
			{
				"box": {
					"id": "obj-96",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						50,
						28,
						15
					],
					"varname": "p2_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 offset"
				}
			},
			{
				"box": {
					"id": "obj-98",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						50,
						30,
						15
					],
					"varname": "p2_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 smooth"
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						50,
						28,
						15
					],
					"varname": "p2_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 depth"
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						50,
						28,
						15
					],
					"varname": "p2_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						490,
						110,
						22
					],
					"text": "prepend p 2 value"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						100,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						50,
						32,
						15
					],
					"varname": "man2",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						100,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100,
						570,
						70,
						22
					],
					"text": "resume 2"
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						320,
						30,
						18
					],
					"text": "4",
					"presentation": 1,
					"presentation_rect": [
						4,
						66,
						16,
						15
					],
					"varname": "sel3",
					"texton": "4",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						1.0,
						0.68,
						0.44,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						140,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						370,
						60,
						22
					],
					"text": "select 3"
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						66,
						16,
						15
					],
					"varname": "p3_on",
					"activebgcolor": [
						1.0,
						0.68,
						0.44,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						430,
						90,
						22
					],
					"text": "prepend p 3 on"
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						66,
						28,
						15
					],
					"varname": "p3_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								23.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 cc"
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						66,
						22,
						15
					],
					"varname": "p3_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 channel"
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						66,
						28,
						15
					],
					"varname": "p3_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 min"
				}
			},
			{
				"box": {
					"id": "obj-118",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						66,
						28,
						15
					],
					"varname": "p3_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 max"
				}
			},
			{
				"box": {
					"id": "obj-120",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						66,
						28,
						15
					],
					"varname": "p3_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-121",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 bars"
				}
			},
			{
				"box": {
					"id": "obj-122",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						66,
						28,
						15
					],
					"varname": "p3_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-123",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 offset"
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						66,
						30,
						15
					],
					"varname": "p3_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 smooth"
				}
			},
			{
				"box": {
					"id": "obj-126",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						66,
						28,
						15
					],
					"varname": "p3_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 depth"
				}
			},
			{
				"box": {
					"id": "obj-128",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						66,
						28,
						15
					],
					"varname": "p3_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-129",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						490,
						110,
						22
					],
					"text": "prepend p 3 value"
				}
			},
			{
				"box": {
					"id": "obj-130",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						140,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						66,
						32,
						15
					],
					"varname": "man3",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-131",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						140,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-132",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						140,
						570,
						70,
						22
					],
					"text": "resume 3"
				}
			},
			{
				"box": {
					"id": "obj-133",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						320,
						30,
						18
					],
					"text": "5",
					"presentation": 1,
					"presentation_rect": [
						4,
						82,
						16,
						15
					],
					"varname": "sel4",
					"texton": "5",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						1.0,
						0.47,
						0.6,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-134",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						180,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-135",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						370,
						60,
						22
					],
					"text": "select 4"
				}
			},
			{
				"box": {
					"id": "obj-136",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						82,
						16,
						15
					],
					"varname": "p4_on",
					"activebgcolor": [
						1.0,
						0.47,
						0.6,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-137",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						430,
						90,
						22
					],
					"text": "prepend p 4 on"
				}
			},
			{
				"box": {
					"id": "obj-138",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						82,
						28,
						15
					],
					"varname": "p4_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								24.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-139",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 cc"
				}
			},
			{
				"box": {
					"id": "obj-140",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						82,
						22,
						15
					],
					"varname": "p4_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-141",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 channel"
				}
			},
			{
				"box": {
					"id": "obj-142",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						82,
						28,
						15
					],
					"varname": "p4_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-143",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 min"
				}
			},
			{
				"box": {
					"id": "obj-144",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						82,
						28,
						15
					],
					"varname": "p4_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-145",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 max"
				}
			},
			{
				"box": {
					"id": "obj-146",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						82,
						28,
						15
					],
					"varname": "p4_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-147",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 bars"
				}
			},
			{
				"box": {
					"id": "obj-148",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						82,
						28,
						15
					],
					"varname": "p4_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-149",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 offset"
				}
			},
			{
				"box": {
					"id": "obj-150",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						82,
						30,
						15
					],
					"varname": "p4_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-151",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 smooth"
				}
			},
			{
				"box": {
					"id": "obj-152",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						82,
						28,
						15
					],
					"varname": "p4_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-153",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 depth"
				}
			},
			{
				"box": {
					"id": "obj-154",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						82,
						28,
						15
					],
					"varname": "p4_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-155",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						490,
						110,
						22
					],
					"text": "prepend p 4 value"
				}
			},
			{
				"box": {
					"id": "obj-156",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						180,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						82,
						32,
						15
					],
					"varname": "man4",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-157",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						180,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-158",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						180,
						570,
						70,
						22
					],
					"text": "resume 4"
				}
			},
			{
				"box": {
					"id": "obj-159",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						320,
						30,
						18
					],
					"text": "6",
					"presentation": 1,
					"presentation_rect": [
						4,
						98,
						16,
						15
					],
					"varname": "sel5",
					"texton": "6",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.9,
						0.84,
						0.46,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-160",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						220,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-161",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						370,
						60,
						22
					],
					"text": "select 5"
				}
			},
			{
				"box": {
					"id": "obj-162",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						98,
						16,
						15
					],
					"varname": "p5_on",
					"activebgcolor": [
						0.9,
						0.84,
						0.46,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-163",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						430,
						90,
						22
					],
					"text": "prepend p 5 on"
				}
			},
			{
				"box": {
					"id": "obj-164",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						98,
						28,
						15
					],
					"varname": "p5_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								25.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-165",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 cc"
				}
			},
			{
				"box": {
					"id": "obj-166",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						98,
						22,
						15
					],
					"varname": "p5_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-167",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 channel"
				}
			},
			{
				"box": {
					"id": "obj-168",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						98,
						28,
						15
					],
					"varname": "p5_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-169",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 min"
				}
			},
			{
				"box": {
					"id": "obj-170",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						98,
						28,
						15
					],
					"varname": "p5_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-171",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 max"
				}
			},
			{
				"box": {
					"id": "obj-172",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						98,
						28,
						15
					],
					"varname": "p5_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-173",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 bars"
				}
			},
			{
				"box": {
					"id": "obj-174",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						98,
						28,
						15
					],
					"varname": "p5_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-175",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 offset"
				}
			},
			{
				"box": {
					"id": "obj-176",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						98,
						30,
						15
					],
					"varname": "p5_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-177",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 smooth"
				}
			},
			{
				"box": {
					"id": "obj-178",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						98,
						28,
						15
					],
					"varname": "p5_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-179",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 depth"
				}
			},
			{
				"box": {
					"id": "obj-180",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						98,
						28,
						15
					],
					"varname": "p5_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-181",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						490,
						110,
						22
					],
					"text": "prepend p 5 value"
				}
			},
			{
				"box": {
					"id": "obj-182",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						220,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						98,
						32,
						15
					],
					"varname": "man5",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-183",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						220,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-184",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						220,
						570,
						70,
						22
					],
					"text": "resume 5"
				}
			},
			{
				"box": {
					"id": "obj-185",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						320,
						30,
						18
					],
					"text": "7",
					"presentation": 1,
					"presentation_rect": [
						4,
						114,
						16,
						15
					],
					"varname": "sel6",
					"texton": "7",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.49,
						0.89,
						0.93,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-186",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						260,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-187",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						370,
						60,
						22
					],
					"text": "select 6"
				}
			},
			{
				"box": {
					"id": "obj-188",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						114,
						16,
						15
					],
					"varname": "p6_on",
					"activebgcolor": [
						0.49,
						0.89,
						0.93,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-189",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						430,
						90,
						22
					],
					"text": "prepend p 6 on"
				}
			},
			{
				"box": {
					"id": "obj-190",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						114,
						28,
						15
					],
					"varname": "p6_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								26.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-191",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 cc"
				}
			},
			{
				"box": {
					"id": "obj-192",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						114,
						22,
						15
					],
					"varname": "p6_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-193",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 channel"
				}
			},
			{
				"box": {
					"id": "obj-194",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						114,
						28,
						15
					],
					"varname": "p6_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-195",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 min"
				}
			},
			{
				"box": {
					"id": "obj-196",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						114,
						28,
						15
					],
					"varname": "p6_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-197",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 max"
				}
			},
			{
				"box": {
					"id": "obj-198",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						114,
						28,
						15
					],
					"varname": "p6_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-199",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 bars"
				}
			},
			{
				"box": {
					"id": "obj-200",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						114,
						28,
						15
					],
					"varname": "p6_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-201",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 offset"
				}
			},
			{
				"box": {
					"id": "obj-202",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						114,
						30,
						15
					],
					"varname": "p6_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-203",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 smooth"
				}
			},
			{
				"box": {
					"id": "obj-204",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						114,
						28,
						15
					],
					"varname": "p6_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-205",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 depth"
				}
			},
			{
				"box": {
					"id": "obj-206",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						114,
						28,
						15
					],
					"varname": "p6_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-207",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						490,
						110,
						22
					],
					"text": "prepend p 6 value"
				}
			},
			{
				"box": {
					"id": "obj-208",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						260,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						114,
						32,
						15
					],
					"varname": "man6",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-209",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						260,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-210",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						260,
						570,
						70,
						22
					],
					"text": "resume 6"
				}
			},
			{
				"box": {
					"id": "obj-211",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						320,
						30,
						18
					],
					"text": "8",
					"presentation": 1,
					"presentation_rect": [
						4,
						130,
						16,
						15
					],
					"varname": "sel7",
					"texton": "8",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.64,
						0.86,
						0.51,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						0,
						0,
						0,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-212",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						300,
						345,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-213",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						370,
						60,
						22
					],
					"text": "select 7"
				}
			},
			{
				"box": {
					"id": "obj-214",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						400,
						20,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						22,
						130,
						16,
						15
					],
					"varname": "p7_on",
					"activebgcolor": [
						0.64,
						0.86,
						0.51,
						1.0
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 On",
							"parameter_mmax": 1.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "On",
							"parameter_type": 2,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-215",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						430,
						90,
						22
					],
					"text": "prepend p 7 on"
				}
			},
			{
				"box": {
					"id": "obj-216",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						40,
						130,
						28,
						15
					],
					"varname": "p7_cc",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 CC",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "CC",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								27.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-217",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 cc"
				}
			},
			{
				"box": {
					"id": "obj-218",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						70,
						130,
						22,
						15
					],
					"varname": "p7_channel",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Canal",
							"parameter_mmax": 16.0,
							"parameter_mmin": 1.0,
							"parameter_shortname": "Canal",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								16.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-219",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 channel"
				}
			},
			{
				"box": {
					"id": "obj-220",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						94,
						130,
						28,
						15
					],
					"varname": "p7_min",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Min",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Min",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-221",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 min"
				}
			},
			{
				"box": {
					"id": "obj-222",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						124,
						130,
						28,
						15
					],
					"varname": "p7_max",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Max",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Max",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-223",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 max"
				}
			},
			{
				"box": {
					"id": "obj-224",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						154,
						130,
						28,
						15
					],
					"varname": "p7_bars",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Mesures",
							"parameter_mmax": 32.0,
							"parameter_mmin": 0.25,
							"parameter_shortname": "Mesures",
							"parameter_type": 0,
							"parameter_unitstyle": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								4.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-225",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 bars"
				}
			},
			{
				"box": {
					"id": "obj-226",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						184,
						130,
						28,
						15
					],
					"varname": "p7_offset",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Phase",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Phase",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-227",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 offset"
				}
			},
			{
				"box": {
					"id": "obj-228",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						214,
						130,
						30,
						15
					],
					"varname": "p7_smooth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Lissage",
							"parameter_mmax": 500.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Lissage",
							"parameter_type": 0,
							"parameter_unitstyle": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								20.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-229",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 smooth"
				}
			},
			{
				"box": {
					"id": "obj-230",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						246,
						130,
						28,
						15
					],
					"varname": "p7_depth",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Profondeur",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Profondeur",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-231",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 depth"
				}
			},
			{
				"box": {
					"id": "obj-232",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						460,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						130,
						28,
						15
					],
					"varname": "p7_value",
					"fontsize": 8.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Valeur",
							"parameter_mmax": 127.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Valeur",
							"parameter_type": 1,
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								64.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-233",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						490,
						110,
						22
					],
					"text": "prepend p 7 value"
				}
			},
			{
				"box": {
					"id": "obj-234",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						520,
						30,
						18
					],
					"text": "AUTO",
					"presentation": 1,
					"presentation_rect": [
						306,
						130,
						32,
						15
					],
					"varname": "man7",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 8.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						0.8,
						0.9,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-235",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						300,
						545,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-236",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						570,
						70,
						22
					],
					"text": "resume 7"
				}
			},
			{
				"box": {
					"id": "obj-237",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Libre",
					"presentation": 1,
					"presentation_rect": [
						344,
						118,
						40,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-238",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn free"
				}
			},
			{
				"box": {
					"id": "obj-239",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Points",
					"presentation": 1,
					"presentation_rect": [
						386,
						118,
						44,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-240",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn points"
				}
			},
			{
				"box": {
					"id": "obj-241",
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"patching_rect": [
						300,
						600,
						90,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						432,
						118,
						72,
						17
					],
					"varname": "shapemenu",
					"items": [
						"Forme...",
						",",
						"Vague",
						",",
						"Rampe +",
						",",
						"Rampe -",
						",",
						"Triangle",
						",",
						"Douce",
						",",
						"Paliers"
					],
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-242",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						625,
						110,
						22
					],
					"text": "prepend shape_preset"
				}
			},
			{
				"box": {
					"id": "obj-243",
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"patching_rect": [
						300,
						600,
						90,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						506,
						118,
						66,
						17
					],
					"varname": "gridmenu",
					"items": [
						"Grille 4",
						",",
						"Grille 8",
						",",
						"Grille 16",
						",",
						"Grille 32",
						",",
						"Grille 64"
					],
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-244",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						625,
						110,
						22
					],
					"text": "prepend setgridindex"
				}
			},
			{
				"box": {
					"id": "obj-245",
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"patching_rect": [
						300,
						600,
						90,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						574,
						118,
						82,
						17
					],
					"varname": "brushmenu",
					"items": [
						"Trait libre",
						",",
						"Motif rampe",
						",",
						"Motif triangle",
						",",
						"Motif sinus"
					],
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-246",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						625,
						110,
						22
					],
					"text": "prepend setbrush"
				}
			},
			{
				"box": {
					"id": "obj-247",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						660,
						50,
						18
					],
					"text": "Aimant",
					"presentation": 1,
					"presentation_rect": [
						658,
						118,
						52,
						17
					],
					"varname": "snap",
					"texton": "Aimant",
					"mode": 1,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.3,
						0.6,
						0.5,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-248",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						685,
						100,
						22
					],
					"text": "prepend setsnap"
				}
			},
			{
				"box": {
					"id": "obj-249",
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"patching_rect": [
						300,
						600,
						90,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						712,
						118,
						78,
						17
					],
					"varname": "segmenu",
					"items": [
						"Courbe",
						",",
						"Courbe en S",
						",",
						"Palier",
						",",
						"Escalier",
						",",
						"Onde",
						",",
						"Triangle",
						",",
						"Impulsion"
					],
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-250",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						625,
						110,
						22
					],
					"text": "prepend shape_seg"
				}
			},
			{
				"box": {
					"id": "obj-251",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						650,
						50,
						18
					],
					"text": "Étirer -",
					"presentation": 1,
					"presentation_rect": [
						792,
						118,
						44,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-252",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						675,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-253",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						700,
						80,
						22
					],
					"text": "stretch -1"
				}
			},
			{
				"box": {
					"id": "obj-254",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						650,
						50,
						18
					],
					"text": "Étirer +",
					"presentation": 1,
					"presentation_rect": [
						838,
						118,
						44,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-255",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						675,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-256",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						700,
						80,
						22
					],
					"text": "stretch 1"
				}
			},
			{
				"box": {
					"id": "obj-257",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						650,
						50,
						18
					],
					"text": "Pente -",
					"presentation": 1,
					"presentation_rect": [
						884,
						118,
						42,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-258",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						675,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-259",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						700,
						80,
						22
					],
					"text": "tilt -1"
				}
			},
			{
				"box": {
					"id": "obj-260",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						650,
						50,
						18
					],
					"text": "Pente +",
					"presentation": 1,
					"presentation_rect": [
						928,
						118,
						42,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-261",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						20,
						675,
						30,
						22
					],
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-262",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						700,
						80,
						22
					],
					"text": "tilt 1"
				}
			},
			{
				"box": {
					"id": "obj-263",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Copier",
					"presentation": 1,
					"presentation_rect": [
						344,
						137,
						48,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-264",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn copy"
				}
			},
			{
				"box": {
					"id": "obj-265",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Coller",
					"presentation": 1,
					"presentation_rect": [
						394,
						137,
						48,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-266",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn paste"
				}
			},
			{
				"box": {
					"id": "obj-267",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Annuler",
					"presentation": 1,
					"presentation_rect": [
						444,
						137,
						52,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-268",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn undo"
				}
			},
			{
				"box": {
					"id": "obj-269",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Verrou",
					"presentation": 1,
					"presentation_rect": [
						498,
						137,
						48,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-270",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn lock"
				}
			},
			{
				"box": {
					"id": "obj-271",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Inverser",
					"presentation": 1,
					"presentation_rect": [
						548,
						137,
						54,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-272",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn invert"
				}
			},
			{
				"box": {
					"id": "obj-273",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Varier",
					"presentation": 1,
					"presentation_rect": [
						604,
						137,
						46,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-274",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn vary"
				}
			},
			{
				"box": {
					"id": "obj-275",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						300,
						730,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						652,
						137,
						34,
						17
					],
					"varname": "vary_amount",
					"fontsize": 8.0,
					"parameter_enable": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Variation %",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Var",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								5.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-276",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300,
						755,
						110,
						22
					],
					"text": "prepend vary_amount"
				}
			},
			{
				"box": {
					"id": "obj-277",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Lisser",
					"presentation": 1,
					"presentation_rect": [
						688,
						137,
						44,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-278",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn smooth"
				}
			},
			{
				"box": {
					"id": "obj-279",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						420,
						730,
						40,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						734,
						137,
						34,
						17
					],
					"varname": "smooth_amount",
					"fontsize": 8.0,
					"parameter_enable": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Lissage %",
							"parameter_mmax": 100.0,
							"parameter_mmin": 0.0,
							"parameter_shortname": "Liss",
							"parameter_type": 0,
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								30.0
							]
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-280",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						420,
						755,
						120,
						22
					],
					"text": "prepend smooth_amount"
				}
			},
			{
				"box": {
					"id": "obj-281",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						600,
						50,
						18
					],
					"text": "Outils...",
					"presentation": 1,
					"presentation_rect": [
						770,
						137,
						56,
						17
					],
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 9.0,
					"bgcolor": [
						0.2,
						0.2,
						0.24,
						1.0
					],
					"bgoncolor": [
						0.4,
						0.5,
						0.7,
						1.0
					],
					"textcolor": [
						1,
						1,
						1,
						1
					],
					"textoncolor": [
						1,
						1,
						1,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-282",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						625,
						100,
						22
					],
					"text": "prepend btn tools"
				}
			},
			{
				"box": {
					"id": "obj-283",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						600,
						90,
						22
					],
					"text": "loadmess set 2"
				}
			},
			{
				"box": {
					"id": "obj-284",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						630,
						90,
						22
					],
					"text": "loadmess set 1"
				}
			},
			{
				"box": {
					"id": "obj-285",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						660,
						90,
						22
					],
					"text": "loadmess set 5"
				}
			},
			{
				"box": {
					"id": "obj-286",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						690,
						90,
						22
					],
					"text": "loadmess set 30"
				}
			},
			{
				"box": {
					"id": "obj-287",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						720,
						130,
						22
					],
					"text": "loadmess vary_amount 5"
				}
			},
			{
				"box": {
					"id": "obj-288",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500,
						750,
						150,
						22
					],
					"text": "loadmess smooth_amount 30"
				}
			},
			{
				"box": {
					"id": "obj-289",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						20,
						800,
						200,
						20
					],
					"text": "Curve Editor M4L - ANKS Labs",
					"presentation": 1,
					"presentation_rect": [
						344,
						154,
						200,
						13
					],
					"fontsize": 8.0,
					"fontname": "Arial",
					"varname": "status",
					"textcolor": [
						0.85,
						0.85,
						0.9,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-290",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						700,
						260,
						60,
						22
					],
					"text": "p tools",
					"varname": "tools",
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
							120.0,
							120.0,
							560.0,
							440.0
						],
						"bglocked": 0,
						"openinpresentation": 1,
						"default_fontsize": 10.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							5.0,
							5.0
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
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"assistshowspatchername": 0,
						"boxes": [
							{
								"box": {
									"id": "obj-1",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										10,
										300,
										20
									],
									"text": "Courbe",
									"presentation": 1,
									"presentation_rect": [
										10,
										8,
										200,
										20
									],
									"fontsize": 14.0,
									"fontname": "Arial",
									"varname": "lane_title"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										40,
										60,
										20
									],
									"text": "Nom",
									"presentation": 1,
									"presentation_rect": [
										10,
										36,
										60,
										18
									],
									"fontsize": 9.0,
									"fontname": "Arial"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"maxclass": "textedit",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"int",
										"",
										""
									],
									"patching_rect": [
										70,
										40,
										300,
										22
									],
									"presentation": 1,
									"presentation_rect": [
										70,
										34,
										270,
										22
									],
									"varname": "name_edit",
									"lines": 1,
									"bangmode": 0,
									"bgcolor": [
										0.13,
										0.13,
										0.15,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"fontsize": 11.0
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										70,
										300,
										20
									],
									"text": "Décrire le mouvement (français)",
									"presentation": 1,
									"presentation_rect": [
										10,
										64,
										300,
										18
									],
									"fontsize": 9.0,
									"fontname": "Arial"
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "textedit",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"int",
										"",
										""
									],
									"patching_rect": [
										10,
										90,
										560,
										60
									],
									"presentation": 1,
									"presentation_rect": [
										10,
										82,
										520,
										52
									],
									"varname": "desc_edit",
									"lines": 3,
									"bangmode": 0,
									"bgcolor": [
										0.13,
										0.13,
										0.15,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"fontsize": 11.0
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										160,
										400,
										20
									],
									"text": "Code avancé (anglais : duration:, start:, ramp, hold, wave, saw)",
									"presentation": 1,
									"presentation_rect": [
										10,
										138,
										400,
										18
									],
									"fontsize": 9.0,
									"fontname": "Arial"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "textedit",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"int",
										"",
										""
									],
									"patching_rect": [
										10,
										180,
										560,
										60
									],
									"presentation": 1,
									"presentation_rect": [
										10,
										156,
										520,
										52
									],
									"varname": "code_edit",
									"lines": 3,
									"bangmode": 0,
									"bgcolor": [
										0.13,
										0.13,
										0.15,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"fontsize": 11.0
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										250,
										100,
										20
									],
									"text": "Interprétation",
									"presentation": 1,
									"presentation_rect": [
										10,
										214,
										100,
										18
									],
									"fontsize": 9.0,
									"fontname": "Arial"
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										110,
										250,
										450,
										20
									],
									"text": " ",
									"presentation": 1,
									"presentation_rect": [
										100,
										214,
										430,
										34
									],
									"fontsize": 9.0,
									"fontname": "Arial",
									"varname": "interp",
									"textcolor": [
										0.8,
										0.9,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-10",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										10,
										280,
										450,
										20
									],
									"text": " ",
									"presentation": 1,
									"presentation_rect": [
										10,
										252,
										520,
										20
									],
									"fontsize": 9.0,
									"fontname": "Arial",
									"varname": "msg",
									"textcolor": [
										1,
										0.85,
										0.5,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-11",
									"maxclass": "jsui",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										10,
										310,
										300,
										100
									],
									"presentation": 1,
									"presentation_rect": [
										10,
										276,
										520,
										110
									],
									"filename": "curve_ui.js",
									"varname": "preview"
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										320,
										310,
										140,
										22
									],
									"text": "loadmess setpreview 1"
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										600,
										400,
										70,
										22
									],
									"text": "s ---cmd"
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										680,
										100,
										130,
										22
									],
									"text": "prepend text name"
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										680,
										130,
										130,
										22
									],
									"text": "prepend text desc"
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										680,
										160,
										130,
										22
									],
									"text": "prepend text code"
								}
							},
							{
								"box": {
									"id": "obj-17",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										10,
										440,
										90,
										20
									],
									"text": "Prévisualiser",
									"presentation": 1,
									"presentation_rect": [
										330,
										62,
										90,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-18",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										10,
										464,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-19",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										10,
										488,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-20",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										10,
										512,
										120,
										22
									],
									"text": "tools preview_desc"
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										70,
										512,
										40,
										22
									],
									"text": "bang"
								}
							},
							{
								"box": {
									"id": "obj-22",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										110,
										440,
										80,
										20
									],
									"text": "Appliquer",
									"presentation": 1,
									"presentation_rect": [
										424,
										62,
										70,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-23",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										110,
										464,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-24",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										110,
										488,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-25",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										110,
										512,
										120,
										22
									],
									"text": "tools apply_desc"
								}
							},
							{
								"box": {
									"id": "obj-26",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										10,
										520,
										90,
										20
									],
									"text": "Prévisualiser",
									"presentation": 1,
									"presentation_rect": [
										330,
										136,
										90,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-27",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										10,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										10,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-29",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										10,
										592,
										120,
										22
									],
									"text": "tools preview_code"
								}
							},
							{
								"box": {
									"id": "obj-30",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										70,
										592,
										40,
										22
									],
									"text": "bang"
								}
							},
							{
								"box": {
									"id": "obj-31",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										110,
										520,
										80,
										20
									],
									"text": "Appliquer",
									"presentation": 1,
									"presentation_rect": [
										424,
										136,
										70,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-32",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										110,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-33",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										110,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-34",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										110,
										592,
										120,
										22
									],
									"text": "tools apply_code"
								}
							},
							{
								"box": {
									"id": "obj-35",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										200,
										520,
										80,
										20
									],
									"text": "Renommer",
									"presentation": 1,
									"presentation_rect": [
										346,
										34,
										70,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-36",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										200,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-37",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										200,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										200,
										592,
										120,
										22
									],
									"text": "tools rename"
								}
							},
							{
								"box": {
									"id": "obj-39",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										260,
										592,
										40,
										22
									],
									"text": "bang"
								}
							},
							{
								"box": {
									"id": "obj-40",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										290,
										520,
										90,
										20
									],
									"text": "Exporter .mid",
									"presentation": 1,
									"presentation_rect": [
										10,
										392,
										100,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-41",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										290,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-42",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										290,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-43",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										290,
										592,
										120,
										22
									],
									"text": "tools export_mid"
								}
							},
							{
								"box": {
									"id": "obj-44",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										390,
										520,
										100,
										20
									],
									"text": "Exporter session",
									"presentation": 1,
									"presentation_rect": [
										116,
										392,
										110,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-45",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										390,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-46",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										390,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-47",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										390,
										592,
										120,
										22
									],
									"text": "tools export_session"
								}
							},
							{
								"box": {
									"id": "obj-48",
									"maxclass": "live.text",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										"float"
									],
									"patching_rect": [
										500,
										520,
										100,
										20
									],
									"text": "Importer session",
									"presentation": 1,
									"presentation_rect": [
										232,
										392,
										110,
										20
									],
									"mode": 0,
									"parameter_enable": 0,
									"fontsize": 10.0,
									"bgcolor": [
										0.22,
										0.22,
										0.26,
										1.0
									],
									"bgoncolor": [
										0.4,
										0.5,
										0.7,
										1.0
									],
									"textcolor": [
										1,
										1,
										1,
										1
									],
									"textoncolor": [
										1,
										1,
										1,
										1
									]
								}
							},
							{
								"box": {
									"id": "obj-49",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										500,
										544,
										40,
										22
									],
									"text": "sel 1"
								}
							},
							{
								"box": {
									"id": "obj-50",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										500,
										568,
										40,
										22
									],
									"text": "t b b"
								}
							},
							{
								"box": {
									"id": "obj-51",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										500,
										592,
										120,
										22
									],
									"text": "tools import_session"
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-11",
										0
									],
									"source": [
										"obj-12",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-14",
										0
									],
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-14",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										0
									],
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-15",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-16",
										0
									],
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-16",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										0
									],
									"source": [
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-19",
										0
									],
									"source": [
										"obj-18",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-21",
										0
									],
									"source": [
										"obj-19",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-5",
										0
									],
									"source": [
										"obj-21",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-20",
										0
									],
									"source": [
										"obj-19",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-20",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-23",
										0
									],
									"source": [
										"obj-22",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-24",
										0
									],
									"source": [
										"obj-23",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-25",
										0
									],
									"source": [
										"obj-24",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-25",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-27",
										0
									],
									"source": [
										"obj-26",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-28",
										0
									],
									"source": [
										"obj-27",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										0
									],
									"source": [
										"obj-28",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-7",
										0
									],
									"source": [
										"obj-30",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"source": [
										"obj-28",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-29",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-32",
										0
									],
									"source": [
										"obj-31",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-33",
										0
									],
									"source": [
										"obj-32",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-34",
										0
									],
									"source": [
										"obj-33",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-34",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-36",
										0
									],
									"source": [
										"obj-35",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-37",
										0
									],
									"source": [
										"obj-36",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-39",
										0
									],
									"source": [
										"obj-37",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-3",
										0
									],
									"source": [
										"obj-39",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-38",
										0
									],
									"source": [
										"obj-37",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-38",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"source": [
										"obj-40",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-42",
										0
									],
									"source": [
										"obj-41",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-43",
										0
									],
									"source": [
										"obj-42",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-43",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-45",
										0
									],
									"source": [
										"obj-44",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										0
									],
									"source": [
										"obj-45",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-47",
										0
									],
									"source": [
										"obj-46",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-47",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-49",
										0
									],
									"source": [
										"obj-48",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-50",
										0
									],
									"source": [
										"obj-49",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										0
									],
									"source": [
										"obj-50",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"source": [
										"obj-51",
										0
									]
								}
							}
						],
						"dependency_cache": [],
						"autosave": 0
					}
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-2",
						0
					],
					"source": [
						"obj-1",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-4",
						0
					],
					"source": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-4",
						1
					],
					"source": [
						"obj-3",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-4",
						2
					],
					"source": [
						"obj-3",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-5",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-7",
						0
					],
					"source": [
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-8",
						0
					],
					"source": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-9",
						0
					],
					"source": [
						"obj-8",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-5",
						0
					],
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-10",
						0
					],
					"source": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-14",
						0
					],
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15",
						0
					],
					"source": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						0
					],
					"source": [
						"obj-12",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						0
					],
					"source": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-30",
						0
					],
					"source": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-31",
						0
					],
					"source": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-33",
						0
					],
					"source": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-35",
						0
					],
					"source": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						0
					],
					"source": [
						"obj-36",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-39",
						0
					],
					"source": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-41",
						0
					],
					"source": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-43",
						0
					],
					"source": [
						"obj-42",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-43",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-45",
						0
					],
					"source": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-45",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-47",
						0
					],
					"source": [
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-49",
						0
					],
					"source": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-51",
						0
					],
					"source": [
						"obj-50",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-53",
						0
					],
					"source": [
						"obj-52",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-54",
						0
					],
					"source": [
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-56",
						0
					],
					"source": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-57",
						0
					],
					"source": [
						"obj-56",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-57",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-59",
						0
					],
					"source": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-59",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-61",
						0
					],
					"source": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-63",
						0
					],
					"source": [
						"obj-62",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-65",
						0
					],
					"source": [
						"obj-64",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-65",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-67",
						0
					],
					"source": [
						"obj-66",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-67",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-69",
						0
					],
					"source": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-71",
						0
					],
					"source": [
						"obj-70",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-71",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-73",
						0
					],
					"source": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-75",
						0
					],
					"source": [
						"obj-74",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-75",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-77",
						0
					],
					"source": [
						"obj-76",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-77",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-79",
						0
					],
					"source": [
						"obj-78",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-80",
						0
					],
					"source": [
						"obj-79",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-80",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-82",
						0
					],
					"source": [
						"obj-81",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-83",
						0
					],
					"source": [
						"obj-82",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-83",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-85",
						0
					],
					"source": [
						"obj-84",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-85",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-87",
						0
					],
					"source": [
						"obj-86",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-87",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-89",
						0
					],
					"source": [
						"obj-88",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-89",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-91",
						0
					],
					"source": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-91",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-93",
						0
					],
					"source": [
						"obj-92",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-93",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-95",
						0
					],
					"source": [
						"obj-94",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-95",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-97",
						0
					],
					"source": [
						"obj-96",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-97",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-99",
						0
					],
					"source": [
						"obj-98",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-99",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-101",
						0
					],
					"source": [
						"obj-100",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-101",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-103",
						0
					],
					"source": [
						"obj-102",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-103",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-105",
						0
					],
					"source": [
						"obj-104",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-106",
						0
					],
					"source": [
						"obj-105",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-106",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-108",
						0
					],
					"source": [
						"obj-107",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-109",
						0
					],
					"source": [
						"obj-108",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-111",
						0
					],
					"source": [
						"obj-110",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-111",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-113",
						0
					],
					"source": [
						"obj-112",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-115",
						0
					],
					"source": [
						"obj-114",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-115",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-117",
						0
					],
					"source": [
						"obj-116",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-117",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-119",
						0
					],
					"source": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-119",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-121",
						0
					],
					"source": [
						"obj-120",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-121",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-123",
						0
					],
					"source": [
						"obj-122",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-123",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-125",
						0
					],
					"source": [
						"obj-124",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-125",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-127",
						0
					],
					"source": [
						"obj-126",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-127",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-129",
						0
					],
					"source": [
						"obj-128",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-129",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-131",
						0
					],
					"source": [
						"obj-130",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-132",
						0
					],
					"source": [
						"obj-131",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-132",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-134",
						0
					],
					"source": [
						"obj-133",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-135",
						0
					],
					"source": [
						"obj-134",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-135",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-137",
						0
					],
					"source": [
						"obj-136",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-137",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-139",
						0
					],
					"source": [
						"obj-138",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-139",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-141",
						0
					],
					"source": [
						"obj-140",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-141",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-143",
						0
					],
					"source": [
						"obj-142",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-143",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-145",
						0
					],
					"source": [
						"obj-144",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-145",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-147",
						0
					],
					"source": [
						"obj-146",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-147",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-149",
						0
					],
					"source": [
						"obj-148",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-149",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-151",
						0
					],
					"source": [
						"obj-150",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-151",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-153",
						0
					],
					"source": [
						"obj-152",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-153",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-155",
						0
					],
					"source": [
						"obj-154",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-155",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-157",
						0
					],
					"source": [
						"obj-156",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-158",
						0
					],
					"source": [
						"obj-157",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-158",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-160",
						0
					],
					"source": [
						"obj-159",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-161",
						0
					],
					"source": [
						"obj-160",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-161",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-163",
						0
					],
					"source": [
						"obj-162",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-163",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-165",
						0
					],
					"source": [
						"obj-164",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-165",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-167",
						0
					],
					"source": [
						"obj-166",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-167",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-169",
						0
					],
					"source": [
						"obj-168",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-169",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-171",
						0
					],
					"source": [
						"obj-170",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-171",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-173",
						0
					],
					"source": [
						"obj-172",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-173",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-175",
						0
					],
					"source": [
						"obj-174",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-175",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-177",
						0
					],
					"source": [
						"obj-176",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-177",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-179",
						0
					],
					"source": [
						"obj-178",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-179",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-181",
						0
					],
					"source": [
						"obj-180",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-181",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-183",
						0
					],
					"source": [
						"obj-182",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-184",
						0
					],
					"source": [
						"obj-183",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-184",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-186",
						0
					],
					"source": [
						"obj-185",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-187",
						0
					],
					"source": [
						"obj-186",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-187",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-189",
						0
					],
					"source": [
						"obj-188",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-189",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-191",
						0
					],
					"source": [
						"obj-190",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-191",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-193",
						0
					],
					"source": [
						"obj-192",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-193",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-195",
						0
					],
					"source": [
						"obj-194",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-195",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-197",
						0
					],
					"source": [
						"obj-196",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-197",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-199",
						0
					],
					"source": [
						"obj-198",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-199",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						0
					],
					"source": [
						"obj-200",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-201",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-203",
						0
					],
					"source": [
						"obj-202",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-203",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-205",
						0
					],
					"source": [
						"obj-204",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-205",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-207",
						0
					],
					"source": [
						"obj-206",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-207",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-209",
						0
					],
					"source": [
						"obj-208",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-210",
						0
					],
					"source": [
						"obj-209",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-210",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-212",
						0
					],
					"source": [
						"obj-211",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-213",
						0
					],
					"source": [
						"obj-212",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-213",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-215",
						0
					],
					"source": [
						"obj-214",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-215",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-217",
						0
					],
					"source": [
						"obj-216",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-217",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-219",
						0
					],
					"source": [
						"obj-218",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-219",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-221",
						0
					],
					"source": [
						"obj-220",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-221",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-223",
						0
					],
					"source": [
						"obj-222",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-223",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-225",
						0
					],
					"source": [
						"obj-224",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-225",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-227",
						0
					],
					"source": [
						"obj-226",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-227",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-229",
						0
					],
					"source": [
						"obj-228",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-229",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-231",
						0
					],
					"source": [
						"obj-230",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-231",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-233",
						0
					],
					"source": [
						"obj-232",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-233",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-235",
						0
					],
					"source": [
						"obj-234",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-236",
						0
					],
					"source": [
						"obj-235",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-236",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-238",
						0
					],
					"source": [
						"obj-237",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-238",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-240",
						0
					],
					"source": [
						"obj-239",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-240",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-242",
						0
					],
					"source": [
						"obj-241",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-242",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-244",
						0
					],
					"source": [
						"obj-243",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-244",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-246",
						0
					],
					"source": [
						"obj-245",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-246",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-248",
						0
					],
					"source": [
						"obj-247",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-248",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-250",
						0
					],
					"source": [
						"obj-249",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-250",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-252",
						0
					],
					"source": [
						"obj-251",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-253",
						0
					],
					"source": [
						"obj-252",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-253",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-255",
						0
					],
					"source": [
						"obj-254",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-256",
						0
					],
					"source": [
						"obj-255",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-256",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-258",
						0
					],
					"source": [
						"obj-257",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-259",
						0
					],
					"source": [
						"obj-258",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-259",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-261",
						0
					],
					"source": [
						"obj-260",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-262",
						0
					],
					"source": [
						"obj-261",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"source": [
						"obj-262",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-264",
						0
					],
					"source": [
						"obj-263",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-264",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-266",
						0
					],
					"source": [
						"obj-265",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-266",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-268",
						0
					],
					"source": [
						"obj-267",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-268",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-270",
						0
					],
					"source": [
						"obj-269",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-270",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-272",
						0
					],
					"source": [
						"obj-271",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-272",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-274",
						0
					],
					"source": [
						"obj-273",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-274",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-276",
						0
					],
					"source": [
						"obj-275",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-276",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-278",
						0
					],
					"source": [
						"obj-277",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-278",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-280",
						0
					],
					"source": [
						"obj-279",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-280",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-282",
						0
					],
					"source": [
						"obj-281",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-282",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-243",
						0
					],
					"source": [
						"obj-283",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-247",
						0
					],
					"source": [
						"obj-284",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-275",
						0
					],
					"source": [
						"obj-285",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-279",
						0
					],
					"source": [
						"obj-286",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-287",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"source": [
						"obj-288",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
