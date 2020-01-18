Scriptname DynamicGlass:Manager extends Quest

Group References
	ObjectReference Property DynamicGlass_Reference Auto Const Mandatory
	ObjectReference Property DynamicGlass_ButtonOn Auto Const Mandatory
	ObjectReference Property DynamicGlass_ButtonOff Auto Const Mandatory
	ObjectReference Property DynamicGlass_ButtonReset Auto Const Mandatory
EndGroup


; Materials
MatSwap DynamicGlass_MSWP ; {DynamicGlass_Default [MSWP:0x00001740]}
MatSwap:RemapData[] Remapping
MatSwap:RemapData Remap

string GlassSource = "Shared\\GlassTile01Off.bgem" const
string Glass100 = "Shared\\Glass100.bgem" const
string Glass095 = "Shared\\Glass095.bgem" const
string Glass090 = "Shared\\Glass090.bgem" const
string Glass085 = "Shared\\Glass085.bgem" const
string Glass080 = "Shared\\Glass080.bgem" const
string Glass075 = "Shared\\Glass075.bgem" const
string Glass070 = "Shared\\Glass070.bgem" const
string Glass065 = "Shared\\Glass065.bgem" const
string Glass060 = "Shared\\Glass060.bgem" const
string Glass055 = "Shared\\Glass055.bgem" const
string Glass050 = "Shared\\Glass050.bgem" const
string Glass045 = "Shared\\Glass045.bgem" const
string Glass040 = "Shared\\Glass040.bgem" const
string Glass035 = "Shared\\Glass035.bgem" const
string Glass030 = "Shared\\Glass030.bgem" const
string Glass025 = "Shared\\Glass025.bgem" const
string Glass020 = "Shared\\Glass020.bgem" const
string Glass015 = "Shared\\Glass015.bgem" const
string Glass010 = "Shared\\Glass010.bgem" const
string Glass005 = "Shared\\Glass005.bgem" const
string Glass000 = "Shared\\Glass000.bgem" const


; Events
;---------------------------------------------

Event OnQuestInit()
	Debug.TraceSelf(self, "OnQuestInit", "Starting up the manager quest.")
	DynamicGlass_MSWP = Game.GetFormFromFile(0x00001740, "DynamicGlass.esp") as MatSwap

	Remapping = new MatSwap:RemapData[0]
	Remap = new MatSwap:RemapData
	Remap.Source = GlassSource
	Remap.Target = GlassSource
	Remapping.Add(Remap)

	RegisterForRemoteEvent(DynamicGlass_ButtonOn, "OnActivate")
	RegisterForRemoteEvent(DynamicGlass_ButtonOff, "OnActivate")
	RegisterForRemoteEvent(DynamicGlass_ButtonReset, "OnActivate")
EndEvent


Event ObjectReference.OnActivate(ObjectReference sender, ObjectReference actionReference)
	Debug.TraceSelf(self, "ObjectReference.OnActivate", "")
	int min = 0 const
	int max = 100 const
	int step = 5 const
	float wait = 0.1 const

	If (sender == DynamicGlass_ButtonOn)
		int percent = min
		While (percent < max + step)
			Utility.Wait(wait)
			Set(percent)
			percent += step
		EndWhile

	ElseIf (sender == DynamicGlass_ButtonOff)
		int percent = max
		While (percent > min - step)
			Utility.Wait(wait)
			Set(percent)
			percent -= step
		EndWhile

	ElseIf (sender == DynamicGlass_ButtonReset)
		Apply(GlassSource)

	Else
		Debug.TraceSelf(self, "ObjectReference.OnActivate", "The sender is none or unhandled.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function Set(int percent)
	Debug.TraceSelf(self, "Set", "Percent:"+percent)

	If (percent == 100)
		Apply(Glass100)

	ElseIf (percent == 95)
		Apply(Glass095)

	ElseIf (percent == 90)
		Apply(Glass090)

	ElseIf (percent == 85)
		Apply(Glass085)

	ElseIf (percent == 80)
		Apply(Glass080)

	ElseIf (percent == 75)
		Apply(Glass075)

	ElseIf (percent == 70)
		Apply(Glass070)

	ElseIf (percent == 65)
		Apply(Glass065)

	ElseIf (percent == 60)
		Apply(Glass060)

	ElseIf (percent == 55)
		Apply(Glass055)

	ElseIf (percent == 50)
		Apply(Glass050)

	ElseIf (percent == 45)
		Apply(Glass045)

	ElseIf (percent == 40)
		Apply(Glass040)

	ElseIf (percent == 35)
		Apply(Glass035)

	ElseIf (percent == 30)
		Apply(Glass030)

	ElseIf (percent == 25)
		Apply(Glass025)

	ElseIf (percent == 20)
		Apply(Glass020)

	ElseIf (percent == 15)
		Apply(Glass015)

	ElseIf (percent == 10)
		Apply(Glass010)

	ElseIf (percent == 5)
		Apply(Glass005)

	ElseIf (percent == 0)
		Apply(Glass000)

	Else
		Debug.TraceSelf(self, "Set", "The percent of "+percent+" is out of range.")
	EndIf
EndFunction


Function Apply(string material)
	If (material)
		Remap.Target = material
		DynamicGlass_MSWP.SetRemapData(Remapping)
		MatSwap:RemapData[] array = DynamicGlass_Reference.ApplyMaterialSwap(DynamicGlass_MSWP)
		If (array)
			Debug.TraceSelf(self, "Apply", "Success:"+material)
		Else
			Debug.TraceSelf(self, "Apply", "Failure:"+material)
		EndIf
	Else
		Debug.TraceSelf(self, "Apply", "The percent material cannot be none.")
	EndIf
EndFunction
