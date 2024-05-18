https://github.com/Nodragem/twin-stick-shooter-starter-kit/assets/10520249/cb1b10fc-a31e-4a98-8d42-ad8bfacd0b1f

# Starter Kit for a Twin-Stick Shooter
Work-in-progress of a twin-stick shooter starter kit for Godot 4 using the FREE [Kaykit Prototype Bits](https://kaylousberg.itch.io/prototype-bits) as a base for the 3D Assets.

**NOTE:** Developed in and compatible with Godot 4.3dev6. It looks like that `MeshLibrary` is breaking compatibility with 4.2. 

# Features:
- Game Feel: Destructible elements, Hit feedback, Recoil animation (more to come)
- Select between 3 controller schemes (One Stick Controller, Two Stick Controller, Two Stick Auto-Shoot Controller)
- Collision layers are set up to reproduce the `infinite_inertia` property which was dropped in Godot 4
- Character Controller based on a State Machine (inspired from GDQuest tutorials)
- Animation System based on a Blend Tree (rather than a State Machine)
- Fully modelled and rigged character
- Support Gamepad or Keyboard (Keyboard + Mouse to be added at some point)
- Easily switch Character's Skin
- Camera follows Main Character and can be rotated with RT/LT
- Debug Layer

# Controls
Press `start` button of your gamepad to open a menu and select between 3 controller schemes:
- One Stick Controller (move with Left Stick, aim with Left Trigger, shoot with B)
- Two Stick Controller (move with Left Stick, aim with Right Stick, shoot with Left Trigger)
- Two Stick Auto-Shoot Controller (move with Left Stick, aim and shoot with Right Stick, Move Camera with RT/LT)

If no Gamepad only the One Stick Controller works at the moment:
- Move with `Arrow` keys
- Jump with `Space` key
- Aim with `Q` key
- Shoot with `W` key (you can only shoot if you are aiming)

Debug Layer which can be toggled with `L` key

# What is coming next?
- Game Feel: adding sounds
- Game Feel: add muzzle and hit VFX
- Add ennemies
