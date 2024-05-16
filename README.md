


https://github.com/Nodragem/twin-stick-shooter-starter-kit/assets/10520249/63aa3e77-3ea0-436c-8e53-90295c0d6212


# Starter Kit for a Twin-Stick Shooter
Work-in-progress of a twin-stick shooter starter kit for Godot 4. Just a one stick shooter where you can jump at the moment!

You will need to download Kenney Prototype Textures from the asset library for the project to run.

(Big Thanks to Kenney for his amazing textures!)

# Features:
- Select between 3 controller schemes (One Stick Controller, Two Stick Controller, Two Stick Auto-Shoot Controller)
- Collision layers are set up to reproduce the `infinite_inertia` property which was dropped in Godot 4
- Character Controller based on a State Machine (inspired from GDQuest tutorials)
- Animation System based on a Blend Tree (rather than a State Machine)
- Fully modelled and rigged character
- Support Gamepad or Keyboard
- Easily switch Character's Skin
- Camera follows Main Character

# Controls
Press `start` button of your gamepad to open a menu and select between 3 controller schemes:
- One Stick Controller (move with Left Stick, aim with Left Trigger, shoot with B)
- Two Stick Controller (move with Left Stick, aim with Right Stick, shoot with Left Trigger)
- Two Stick Auto-Shoot Controller (move with Left Stick, aim and shoot with Right Stick)

If no Gamepad:
- Move with `Arrow` keys
- Jump with `Space` key
- Aim with `Q` key
- Shoot with `W` key (you can only shoot if you are aiming)

Debug Layer which can be toggled with `L` key
