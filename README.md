# Skill demo
This is a demo for moba-like skills using 2D Godot 3.1

The code will be kept as general as possible, but the library is built for a specific gamestyle in mind.


To use, add the `Skills` folder to the `res://` path, for example `res://Skills/`.
It must run with [Godot](https://godotengine.org/)


# How it works
A skill is defined as how it's cast, and what its Effects are. 
Skills begin as either requiring a target (`Target*`) or pressing anywhere (`Ground*`). They do minimal things by themselves, such as report Out of Range, or On Cooldown.
If the skill is able to cast, it will begin playing any Effects of its children.

For example, having a skill with the following tree:
* TargetQueue
    * DashEffect
    * ShieldEffect

Will create a dash and shield toward the selected target. 

Many effects can chain other effects:
* GroundInstant
    * SkillshotEffect
        * AOEEffect
            * DOTEffect

This will create a skill shot that explodes for burn damage in an area of effect. 
