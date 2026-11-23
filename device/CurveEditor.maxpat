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
		"devicewidth": 430.0,
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
					"numoutlets": 4,
					"outlettype": [
						"",
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
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						200,
						260,
						80,
						22
					],
					"text": "s ---toui"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200,
						160,
						70,
						22
					],
					"text": "r ---ui"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						330,
						140,
						70,
						22
					],
					"text": "qmetro 15"
				}
			},
			{
				"box": {
					"id": "obj-8",
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
					"id": "obj-9",
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
					"id": "obj-10",
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
					"id": "obj-11",
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
					"id": "obj-12",
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
					"id": "obj-13",
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
					"id": "obj-14",
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
					"id": "obj-15",
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
					"id": "obj-16",
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
					"id": "obj-17",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						600,
						110,
						120,
						22
					],
					"text": "prepend dialog_path"
				}
			},
			{
				"box": {
					"id": "obj-18",
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
					"id": "obj-19",
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
						14,
						52,
						20,
						20
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
					"id": "obj-20",
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
					"id": "obj-21",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						470,
						60,
						15
					],
					"varname": "p0_min",
					"fontsize": 9.0,
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
					"id": "obj-22",
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
					"id": "obj-23",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						506,
						60,
						15
					],
					"varname": "p0_max",
					"fontsize": 9.0,
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
					"id": "obj-24",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						526,
						110,
						22
					],
					"text": "prepend p 0 max"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						542,
						60,
						15
					],
					"varname": "p0_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L1 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-26",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						562,
						110,
						22
					],
					"text": "prepend p 0 bars"
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						578,
						60,
						15
					],
					"varname": "p0_offset",
					"fontsize": 9.0,
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
					"id": "obj-28",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						598,
						110,
						22
					],
					"text": "prepend p 0 offset"
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						614,
						60,
						15
					],
					"varname": "p0_smooth",
					"fontsize": 9.0,
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
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						634,
						110,
						22
					],
					"text": "prepend p 0 smooth"
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						650,
						60,
						15
					],
					"varname": "p0_depth",
					"fontsize": 9.0,
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
					"id": "obj-32",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						670,
						110,
						22
					],
					"text": "prepend p 0 depth"
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						686,
						60,
						15
					],
					"varname": "p0_value",
					"fontsize": 9.0,
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
					"id": "obj-34",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						706,
						110,
						22
					],
					"text": "prepend p 0 value"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						722,
						60,
						15
					],
					"varname": "p0_cc",
					"fontsize": 9.0,
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
					"id": "obj-36",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						742,
						110,
						22
					],
					"text": "prepend p 0 cc"
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						758,
						60,
						15
					],
					"varname": "p0_channel",
					"fontsize": 9.0,
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
					"id": "obj-38",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						778,
						110,
						22
					],
					"text": "prepend p 0 channel"
				}
			},
			{
				"box": {
					"id": "obj-39",
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
						64,
						52,
						20,
						20
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
					"id": "obj-40",
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
					"id": "obj-41",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						470,
						60,
						15
					],
					"varname": "p1_min",
					"fontsize": 9.0,
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
					"id": "obj-42",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						490,
						110,
						22
					],
					"text": "prepend p 1 min"
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						506,
						60,
						15
					],
					"varname": "p1_max",
					"fontsize": 9.0,
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
					"id": "obj-44",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						526,
						110,
						22
					],
					"text": "prepend p 1 max"
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						542,
						60,
						15
					],
					"varname": "p1_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L2 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-46",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						562,
						110,
						22
					],
					"text": "prepend p 1 bars"
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						578,
						60,
						15
					],
					"varname": "p1_offset",
					"fontsize": 9.0,
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
					"id": "obj-48",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						598,
						110,
						22
					],
					"text": "prepend p 1 offset"
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						614,
						60,
						15
					],
					"varname": "p1_smooth",
					"fontsize": 9.0,
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
					"id": "obj-50",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						634,
						110,
						22
					],
					"text": "prepend p 1 smooth"
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						650,
						60,
						15
					],
					"varname": "p1_depth",
					"fontsize": 9.0,
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
					"id": "obj-52",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						670,
						110,
						22
					],
					"text": "prepend p 1 depth"
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						686,
						60,
						15
					],
					"varname": "p1_value",
					"fontsize": 9.0,
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
					"id": "obj-54",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						706,
						110,
						22
					],
					"text": "prepend p 1 value"
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						722,
						60,
						15
					],
					"varname": "p1_cc",
					"fontsize": 9.0,
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
					"id": "obj-56",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						742,
						110,
						22
					],
					"text": "prepend p 1 cc"
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						150,
						758,
						60,
						15
					],
					"varname": "p1_channel",
					"fontsize": 9.0,
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
					"id": "obj-58",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						150,
						778,
						110,
						22
					],
					"text": "prepend p 1 channel"
				}
			},
			{
				"box": {
					"id": "obj-59",
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
						114,
						52,
						20,
						20
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
					"id": "obj-60",
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
					"id": "obj-61",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						470,
						60,
						15
					],
					"varname": "p2_min",
					"fontsize": 9.0,
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
					"id": "obj-62",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						490,
						110,
						22
					],
					"text": "prepend p 2 min"
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						506,
						60,
						15
					],
					"varname": "p2_max",
					"fontsize": 9.0,
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
					"id": "obj-64",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						526,
						110,
						22
					],
					"text": "prepend p 2 max"
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						542,
						60,
						15
					],
					"varname": "p2_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L3 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-66",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						562,
						110,
						22
					],
					"text": "prepend p 2 bars"
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						578,
						60,
						15
					],
					"varname": "p2_offset",
					"fontsize": 9.0,
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
					"id": "obj-68",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						598,
						110,
						22
					],
					"text": "prepend p 2 offset"
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						614,
						60,
						15
					],
					"varname": "p2_smooth",
					"fontsize": 9.0,
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
					"id": "obj-70",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						634,
						110,
						22
					],
					"text": "prepend p 2 smooth"
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						650,
						60,
						15
					],
					"varname": "p2_depth",
					"fontsize": 9.0,
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
					"id": "obj-72",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						670,
						110,
						22
					],
					"text": "prepend p 2 depth"
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						686,
						60,
						15
					],
					"varname": "p2_value",
					"fontsize": 9.0,
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
					"id": "obj-74",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						706,
						110,
						22
					],
					"text": "prepend p 2 value"
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						722,
						60,
						15
					],
					"varname": "p2_cc",
					"fontsize": 9.0,
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
					"id": "obj-76",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						742,
						110,
						22
					],
					"text": "prepend p 2 cc"
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						280,
						758,
						60,
						15
					],
					"varname": "p2_channel",
					"fontsize": 9.0,
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
					"id": "obj-78",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						280,
						778,
						110,
						22
					],
					"text": "prepend p 2 channel"
				}
			},
			{
				"box": {
					"id": "obj-79",
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
						164,
						52,
						20,
						20
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
					"id": "obj-80",
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
					"id": "obj-81",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						470,
						60,
						15
					],
					"varname": "p3_min",
					"fontsize": 9.0,
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
					"id": "obj-82",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						490,
						110,
						22
					],
					"text": "prepend p 3 min"
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						506,
						60,
						15
					],
					"varname": "p3_max",
					"fontsize": 9.0,
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
					"id": "obj-84",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						526,
						110,
						22
					],
					"text": "prepend p 3 max"
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						542,
						60,
						15
					],
					"varname": "p3_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L4 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-86",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						562,
						110,
						22
					],
					"text": "prepend p 3 bars"
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						578,
						60,
						15
					],
					"varname": "p3_offset",
					"fontsize": 9.0,
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
					"id": "obj-88",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						598,
						110,
						22
					],
					"text": "prepend p 3 offset"
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						614,
						60,
						15
					],
					"varname": "p3_smooth",
					"fontsize": 9.0,
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
					"id": "obj-90",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						634,
						110,
						22
					],
					"text": "prepend p 3 smooth"
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						650,
						60,
						15
					],
					"varname": "p3_depth",
					"fontsize": 9.0,
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
					"id": "obj-92",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						670,
						110,
						22
					],
					"text": "prepend p 3 depth"
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						686,
						60,
						15
					],
					"varname": "p3_value",
					"fontsize": 9.0,
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
					"id": "obj-94",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						706,
						110,
						22
					],
					"text": "prepend p 3 value"
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						722,
						60,
						15
					],
					"varname": "p3_cc",
					"fontsize": 9.0,
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
					"id": "obj-96",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						742,
						110,
						22
					],
					"text": "prepend p 3 cc"
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						410,
						758,
						60,
						15
					],
					"varname": "p3_channel",
					"fontsize": 9.0,
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
					"id": "obj-98",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						410,
						778,
						110,
						22
					],
					"text": "prepend p 3 channel"
				}
			},
			{
				"box": {
					"id": "obj-99",
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
						214,
						52,
						20,
						20
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
					"id": "obj-100",
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
					"id": "obj-101",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						470,
						60,
						15
					],
					"varname": "p4_min",
					"fontsize": 9.0,
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
					"id": "obj-102",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						490,
						110,
						22
					],
					"text": "prepend p 4 min"
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						506,
						60,
						15
					],
					"varname": "p4_max",
					"fontsize": 9.0,
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
					"id": "obj-104",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						526,
						110,
						22
					],
					"text": "prepend p 4 max"
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						542,
						60,
						15
					],
					"varname": "p4_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L5 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-106",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						562,
						110,
						22
					],
					"text": "prepend p 4 bars"
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						578,
						60,
						15
					],
					"varname": "p4_offset",
					"fontsize": 9.0,
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
					"id": "obj-108",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						598,
						110,
						22
					],
					"text": "prepend p 4 offset"
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						614,
						60,
						15
					],
					"varname": "p4_smooth",
					"fontsize": 9.0,
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
					"id": "obj-110",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						634,
						110,
						22
					],
					"text": "prepend p 4 smooth"
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						650,
						60,
						15
					],
					"varname": "p4_depth",
					"fontsize": 9.0,
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
					"id": "obj-112",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						670,
						110,
						22
					],
					"text": "prepend p 4 depth"
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						686,
						60,
						15
					],
					"varname": "p4_value",
					"fontsize": 9.0,
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
					"id": "obj-114",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						706,
						110,
						22
					],
					"text": "prepend p 4 value"
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						722,
						60,
						15
					],
					"varname": "p4_cc",
					"fontsize": 9.0,
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
					"id": "obj-116",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						742,
						110,
						22
					],
					"text": "prepend p 4 cc"
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						540,
						758,
						60,
						15
					],
					"varname": "p4_channel",
					"fontsize": 9.0,
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
					"id": "obj-118",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						540,
						778,
						110,
						22
					],
					"text": "prepend p 4 channel"
				}
			},
			{
				"box": {
					"id": "obj-119",
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
						264,
						52,
						20,
						20
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
					"id": "obj-120",
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
					"id": "obj-121",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						470,
						60,
						15
					],
					"varname": "p5_min",
					"fontsize": 9.0,
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
					"id": "obj-122",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						490,
						110,
						22
					],
					"text": "prepend p 5 min"
				}
			},
			{
				"box": {
					"id": "obj-123",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						506,
						60,
						15
					],
					"varname": "p5_max",
					"fontsize": 9.0,
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
					"id": "obj-124",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						526,
						110,
						22
					],
					"text": "prepend p 5 max"
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						542,
						60,
						15
					],
					"varname": "p5_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L6 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-126",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						562,
						110,
						22
					],
					"text": "prepend p 5 bars"
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						578,
						60,
						15
					],
					"varname": "p5_offset",
					"fontsize": 9.0,
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
					"id": "obj-128",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						598,
						110,
						22
					],
					"text": "prepend p 5 offset"
				}
			},
			{
				"box": {
					"id": "obj-129",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						614,
						60,
						15
					],
					"varname": "p5_smooth",
					"fontsize": 9.0,
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
					"id": "obj-130",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						634,
						110,
						22
					],
					"text": "prepend p 5 smooth"
				}
			},
			{
				"box": {
					"id": "obj-131",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						650,
						60,
						15
					],
					"varname": "p5_depth",
					"fontsize": 9.0,
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
					"id": "obj-132",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						670,
						110,
						22
					],
					"text": "prepend p 5 depth"
				}
			},
			{
				"box": {
					"id": "obj-133",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						686,
						60,
						15
					],
					"varname": "p5_value",
					"fontsize": 9.0,
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
					"id": "obj-134",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						706,
						110,
						22
					],
					"text": "prepend p 5 value"
				}
			},
			{
				"box": {
					"id": "obj-135",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						722,
						60,
						15
					],
					"varname": "p5_cc",
					"fontsize": 9.0,
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
					"id": "obj-136",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						742,
						110,
						22
					],
					"text": "prepend p 5 cc"
				}
			},
			{
				"box": {
					"id": "obj-137",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						670,
						758,
						60,
						15
					],
					"varname": "p5_channel",
					"fontsize": 9.0,
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
					"id": "obj-138",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						670,
						778,
						110,
						22
					],
					"text": "prepend p 5 channel"
				}
			},
			{
				"box": {
					"id": "obj-139",
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
						314,
						52,
						20,
						20
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
					"id": "obj-140",
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
					"id": "obj-141",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						470,
						60,
						15
					],
					"varname": "p6_min",
					"fontsize": 9.0,
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
					"id": "obj-142",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						490,
						110,
						22
					],
					"text": "prepend p 6 min"
				}
			},
			{
				"box": {
					"id": "obj-143",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						506,
						60,
						15
					],
					"varname": "p6_max",
					"fontsize": 9.0,
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
					"id": "obj-144",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						526,
						110,
						22
					],
					"text": "prepend p 6 max"
				}
			},
			{
				"box": {
					"id": "obj-145",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						542,
						60,
						15
					],
					"varname": "p6_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L7 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-146",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						562,
						110,
						22
					],
					"text": "prepend p 6 bars"
				}
			},
			{
				"box": {
					"id": "obj-147",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						578,
						60,
						15
					],
					"varname": "p6_offset",
					"fontsize": 9.0,
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
					"id": "obj-148",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						598,
						110,
						22
					],
					"text": "prepend p 6 offset"
				}
			},
			{
				"box": {
					"id": "obj-149",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						614,
						60,
						15
					],
					"varname": "p6_smooth",
					"fontsize": 9.0,
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
					"id": "obj-150",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						634,
						110,
						22
					],
					"text": "prepend p 6 smooth"
				}
			},
			{
				"box": {
					"id": "obj-151",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						650,
						60,
						15
					],
					"varname": "p6_depth",
					"fontsize": 9.0,
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
					"id": "obj-152",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						670,
						110,
						22
					],
					"text": "prepend p 6 depth"
				}
			},
			{
				"box": {
					"id": "obj-153",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						686,
						60,
						15
					],
					"varname": "p6_value",
					"fontsize": 9.0,
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
					"id": "obj-154",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						706,
						110,
						22
					],
					"text": "prepend p 6 value"
				}
			},
			{
				"box": {
					"id": "obj-155",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						722,
						60,
						15
					],
					"varname": "p6_cc",
					"fontsize": 9.0,
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
					"id": "obj-156",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						742,
						110,
						22
					],
					"text": "prepend p 6 cc"
				}
			},
			{
				"box": {
					"id": "obj-157",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						800,
						758,
						60,
						15
					],
					"varname": "p6_channel",
					"fontsize": 9.0,
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
					"id": "obj-158",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						800,
						778,
						110,
						22
					],
					"text": "prepend p 6 channel"
				}
			},
			{
				"box": {
					"id": "obj-159",
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
						364,
						52,
						20,
						20
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
					"id": "obj-160",
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
					"id": "obj-161",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						470,
						60,
						15
					],
					"varname": "p7_min",
					"fontsize": 9.0,
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
					"id": "obj-162",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						490,
						110,
						22
					],
					"text": "prepend p 7 min"
				}
			},
			{
				"box": {
					"id": "obj-163",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						506,
						60,
						15
					],
					"varname": "p7_max",
					"fontsize": 9.0,
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
					"id": "obj-164",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						526,
						110,
						22
					],
					"text": "prepend p 7 max"
				}
			},
			{
				"box": {
					"id": "obj-165",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						542,
						60,
						15
					],
					"varname": "p7_bars",
					"fontsize": 9.0,
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "L8 Mesures",
							"parameter_mmax": 16.0,
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
					"id": "obj-166",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						562,
						110,
						22
					],
					"text": "prepend p 7 bars"
				}
			},
			{
				"box": {
					"id": "obj-167",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						578,
						60,
						15
					],
					"varname": "p7_offset",
					"fontsize": 9.0,
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
					"id": "obj-168",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						598,
						110,
						22
					],
					"text": "prepend p 7 offset"
				}
			},
			{
				"box": {
					"id": "obj-169",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						614,
						60,
						15
					],
					"varname": "p7_smooth",
					"fontsize": 9.0,
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
					"id": "obj-170",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						634,
						110,
						22
					],
					"text": "prepend p 7 smooth"
				}
			},
			{
				"box": {
					"id": "obj-171",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						650,
						60,
						15
					],
					"varname": "p7_depth",
					"fontsize": 9.0,
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
					"id": "obj-172",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						670,
						110,
						22
					],
					"text": "prepend p 7 depth"
				}
			},
			{
				"box": {
					"id": "obj-173",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						686,
						60,
						15
					],
					"varname": "p7_value",
					"fontsize": 9.0,
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
					"id": "obj-174",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						706,
						110,
						22
					],
					"text": "prepend p 7 value"
				}
			},
			{
				"box": {
					"id": "obj-175",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						722,
						60,
						15
					],
					"varname": "p7_cc",
					"fontsize": 9.0,
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
					"id": "obj-176",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						742,
						110,
						22
					],
					"text": "prepend p 7 cc"
				}
			},
			{
				"box": {
					"id": "obj-177",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						930,
						758,
						60,
						15
					],
					"varname": "p7_channel",
					"fontsize": 9.0,
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
					"id": "obj-178",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						930,
						778,
						110,
						22
					],
					"text": "prepend p 7 channel"
				}
			},
			{
				"box": {
					"id": "obj-179",
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
					"text": "Curve Mini  -  Max for Live",
					"presentation": 1,
					"presentation_rect": [
						10,
						4,
						300,
						22
					],
					"fontsize": 14.0,
					"fontname": "Arial",
					"textcolor": [
						0.93,
						0.95,
						0.94,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-180",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						20,
						830,
						20,
						20
					],
					"text": "1",
					"presentation": 1,
					"presentation_rect": [
						20,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.26,
						0.87,
						0.74,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-181",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						60,
						830,
						20,
						20
					],
					"text": "2",
					"presentation": 1,
					"presentation_rect": [
						70,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.41,
						0.71,
						1.0,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-182",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						100,
						830,
						20,
						20
					],
					"text": "3",
					"presentation": 1,
					"presentation_rect": [
						120,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.8,
						0.57,
						1.0,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-183",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						140,
						830,
						20,
						20
					],
					"text": "4",
					"presentation": 1,
					"presentation_rect": [
						170,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						1.0,
						0.68,
						0.44,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-184",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						180,
						830,
						20,
						20
					],
					"text": "5",
					"presentation": 1,
					"presentation_rect": [
						220,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						1.0,
						0.47,
						0.6,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-185",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						220,
						830,
						20,
						20
					],
					"text": "6",
					"presentation": 1,
					"presentation_rect": [
						270,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.9,
						0.84,
						0.46,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-186",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						260,
						830,
						20,
						20
					],
					"text": "7",
					"presentation": 1,
					"presentation_rect": [
						320,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.49,
						0.89,
						0.93,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-187",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						300,
						830,
						20,
						20
					],
					"text": "8",
					"presentation": 1,
					"presentation_rect": [
						370,
						36,
						14,
						16
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"textcolor": [
						0.64,
						0.86,
						0.51,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-188",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"patching_rect": [
						20,
						860,
						160,
						24
					],
					"text": "Ouvrir l'éditeur",
					"presentation": 1,
					"presentation_rect": [
						12,
						84,
						170,
						28
					],
					"varname": "open_button",
					"mode": 0,
					"parameter_enable": 0,
					"fontsize": 12.0,
					"bgcolor": [
						0.2,
						0.28,
						0.4,
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
					"id": "obj-189",
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
						890,
						70,
						22
					],
					"text": "route 1 bang"
				}
			},
			{
				"box": {
					"id": "obj-190",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						20,
						920,
						40,
						22
					],
					"text": "t b b"
				}
			},
			{
				"box": {
					"id": "obj-191",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						70,
						950,
						60,
						22
					],
					"text": "sync_all"
				}
			},
			{
				"box": {
					"id": "obj-192",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						20,
						950,
						40,
						22
					],
					"text": "open"
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
						20,
						980,
						60,
						22
					],
					"text": "pcontrol"
				}
			},
			{
				"box": {
					"id": "obj-194",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						200,
						800,
						300,
						20
					],
					"text": "Curve Editor M4L",
					"presentation": 1,
					"presentation_rect": [
						12,
						122,
						406,
						40
					],
					"fontsize": 10.0,
					"fontname": "Arial",
					"varname": "status",
					"textcolor": [
						0.7,
						0.78,
						0.9,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-195",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						20,
						1010,
						60,
						22
					],
					"text": "p editor",
					"varname": "editor",
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
							80.0,
							720.0,
							780.0
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
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										10,
										10,
										30,
										30
									],
									"comment": ""
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "jsui",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										0,
										0,
										720,
										780
									],
									"presentation": 1,
									"presentation_rect": [
										0,
										0,
										720,
										780
									],
									"filename": "curve_ui.js",
									"varname": "ui"
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
										16,
										976,
										556,
										30
									],
									"presentation": 1,
									"presentation_rect": [
										16,
										176,
										556,
										30
									],
									"varname": "name_edit",
									"hidden": 1,
									"lines": 1,
									"bgcolor": [
										0.1,
										0.12,
										0.17,
										1.0
									],
									"textcolor": [
										0.93,
										0.95,
										0.94,
										1.0
									],
									"fontsize": 12.0,
									"fontname": "Arial",
									"border": 1,
									"bordercolor": [
										0.2,
										0.26,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										592,
										976,
										120,
										22
									],
									"text": "prepend edit_name"
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
										16,
										994,
										688,
										125
									],
									"presentation": 1,
									"presentation_rect": [
										16,
										194,
										688,
										125
									],
									"varname": "body_edit",
									"hidden": 1,
									"lines": 8,
									"bgcolor": [
										0.1,
										0.12,
										0.17,
										1.0
									],
									"textcolor": [
										0.93,
										0.95,
										0.94,
										1.0
									],
									"fontsize": 12.0,
									"fontname": "Arial",
									"border": 1,
									"bordercolor": [
										0.2,
										0.26,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										724,
										994,
										120,
										22
									],
									"text": "prepend edit_body"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										760,
										20,
										80,
										22
									],
									"text": "r ---toui"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"outlettype": [],
									"patching_rect": [
										760,
										60,
										70,
										22
									],
									"text": "s ---ui"
								}
							}
						],
						"lines": [
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
										"obj-2",
										0
									],
									"source": [
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-6",
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
										"obj-2",
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
										"obj-2",
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
										"obj-8",
										0
									],
									"source": [
										"obj-2",
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
						"obj-5",
						0
					],
					"source": [
						"obj-3",
						3
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
						"obj-6",
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
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-11",
						0
					],
					"source": [
						"obj-10",
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
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
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
						"obj-12",
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
						"obj-13",
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
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-17",
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
						"obj-18",
						0
					],
					"source": [
						"obj-14",
						2
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
						"obj-15",
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
						"obj-18",
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
						"obj-3",
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
						"obj-22",
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
						"obj-3",
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
						"obj-3",
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
						"obj-26",
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
						"obj-3",
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
						"obj-3",
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
						"obj-3",
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
						"obj-3",
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
						"obj-3",
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
						"obj-3",
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
						"obj-3",
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
						"obj-40",
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
						"obj-3",
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
						"obj-3",
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
						"obj-44",
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
						"obj-3",
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
						"obj-3",
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
						"obj-48",
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
						"obj-3",
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
						"obj-3",
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
						"obj-52",
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
						"obj-3",
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
						"obj-3",
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
						"obj-58",
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
						"obj-3",
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
						"obj-60",
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
						"obj-3",
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
						"obj-62",
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
						"obj-3",
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
						"obj-64",
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
						"obj-3",
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
						"obj-66",
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
						"obj-3",
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
						"obj-68",
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
						"obj-3",
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
						"obj-70",
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
						"obj-3",
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
						"obj-72",
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
						"obj-3",
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
						"obj-74",
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
						"obj-3",
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
						"obj-76",
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
						"obj-3",
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
						"obj-78",
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
						"obj-3",
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
						"obj-3",
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
						"obj-84",
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
						"obj-3",
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
						"obj-86",
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
						"obj-3",
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
						"obj-88",
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
						"obj-3",
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
						"obj-90",
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
						"obj-3",
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
						"obj-92",
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
						"obj-3",
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
						"obj-94",
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
						"obj-3",
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
						"obj-96",
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
						"obj-3",
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
						"obj-98",
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
						"obj-3",
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
						"obj-100",
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
						"obj-3",
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
						"obj-102",
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
						"obj-3",
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
						"obj-104",
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
						"obj-3",
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
						"obj-3",
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
						"obj-110",
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
						"obj-3",
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
						"obj-112",
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
						"obj-3",
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
						"obj-114",
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
						"obj-3",
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
						"obj-116",
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
						"obj-3",
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
						"obj-118",
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
						"obj-3",
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
						"obj-120",
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
						"obj-3",
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
						"obj-122",
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
						"obj-3",
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
						"obj-124",
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
						"obj-3",
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
						"obj-126",
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
						"obj-3",
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
						"obj-128",
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
						"obj-3",
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
						"obj-130",
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
						"obj-3",
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
						"obj-3",
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
						"obj-136",
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
						"obj-3",
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
						"obj-138",
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
						"obj-3",
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
						"obj-140",
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
						"obj-3",
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
						"obj-142",
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
						"obj-3",
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
						"obj-144",
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
						"obj-3",
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
						"obj-146",
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
						"obj-3",
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
						"obj-148",
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
						"obj-3",
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
						"obj-150",
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
						"obj-3",
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
						"obj-152",
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
						"obj-3",
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
						"obj-154",
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
						"obj-3",
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
						"obj-156",
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
						"obj-3",
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
						"obj-3",
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
						"obj-162",
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
						"obj-3",
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
						"obj-164",
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
						"obj-3",
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
						"obj-166",
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
						"obj-3",
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
						"obj-168",
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
						"obj-3",
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
						"obj-170",
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
						"obj-3",
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
						"obj-172",
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
						"obj-3",
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
						"obj-174",
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
						"obj-3",
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
						"obj-176",
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
						"obj-3",
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
						"obj-178",
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
						"obj-3",
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
						"obj-190",
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
						"obj-190",
						0
					],
					"source": [
						"obj-189",
						1
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
						"obj-191",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-192",
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
						"obj-195",
						0
					],
					"source": [
						"obj-193",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
