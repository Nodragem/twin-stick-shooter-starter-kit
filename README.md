https://github.com/Nodragem/twin-stick-shooter-starter-kit/assets/10520249/1065d193-dbbc-4b55-8ce3-8ffaed277bab

# Starter Kit for a Twin-Stick Shooter
Work-in-progress of a twin-stick shooter starter kit for Godot 4. Just a one stick shooter where you can jump at the moment!
You will need to download Kenney Prototype Textures from the asset library for the project to run.
(Big Thanks to Kenney for his amazing textures!)

# Features:
- Collision layers are set up to reproduce the `infinite_inertia` property which was dropped in Godot 4
- Character Controller based on a State Machine (inspired from GDQuest tutorials)
- Animation System based on a Blend Tree (rather than a State Machine), see below
- Fully modelled and rigged character
- Support Gamepad or Keyboard
- Only shoot when in Aiming State
- Easily switch Character's Skin
- Camera follows Main Character
- Debug Layer which can be toggled with `L` key

# Controls
- Move with `Left Stick` or `Arrow` keys
- Jump with `A` button or `Space` key
- Aim with `Right Trigger` or `Q`
- Shoot with `B` button or `W` key (you can only shoot if you are aiming)
