# Skill demo
This is a demo for moba-like skills using Godot 3.1

Scenes will change throughout commits for testing. GDScript files are the most important here.

The code will be kept as general as possible, but the library is built for a specific gamestyle in mind.


There are no compiled binaries available. It must run with [Godot](https://godotengine.org/)


# How it works
A skill is defined as how it's cast, and what its Effects are. 
Skills begin as either requiring a target (`TargetQueue`) or pressing anywhere (`GroundImmediate`). They barely do anything by themselves. They will only report notices such as Out of Range, or On Cooldown.
If the skill is able to cast, it will begin playing any Effects of its children.

For example, having a skill with the following tree:
* TargetQueue
    * DashEffect
    * ShieldEffect

Will create a dash and shield toward the selected target. 

Many effects can chain other effects:
* GroundImmediate
    * SkillshotEffect
        * AOEEffect
            * BurnEffect

This will create a skill shot that explodes for burn damage in an area of effect. 
