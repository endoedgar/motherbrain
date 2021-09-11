; NORMAL VERSION

; Sofrendo do ultra-laser
[Statedef 15963]
type = A
movetype = H
physics = N
anim = 5000
ctrl = 0
sprpriority = -4

[State 15963, SelfState]
type = SelfState
trigger1 = !alive
value = 5050
ignorehitpause = 1

[State 15963, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 15963, ScreenBound]
type = ScreenBound
trigger1 = 1
value = 1
ignorehitpause = 1

[State 15963, ChangeAnim]
type = ChangeAnim
trigger1 = time = 0
value = ifelse(selfanimexist(5012), 5012, 5000)
ignorehitpause = 1

[State 15963, Explod]
type = Explod
trigger1 = time % 3 = 0
anim = Fifelse(random <= 500, 0, ifelse(random <= 500, 1, ifelse(random <= 500, 2, 3)))
ID = 555
pos = Const(size.mid.pos.x),Const(size.mid.pos.y)
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = abs(Const(size.mid.pos.x)),abs(Const(size.mid.pos.y))
removetime = -2
scale = 1,1
sprpriority = 0
ontop = 0
shadow = -1,-1,-1
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State 15963, VelSet]
type = VelSet
trigger1 = 1
x = -5
ignorehitpause = 1

[State 15963, LifeSet]
type = LifeAdd
trigger1 = !(time % 2)
value = -ceil(1.0*(lifemax/1000.0))
ignorehitpause = 1

[State 15963, LifeSet]
type = PowerAdd
trigger1 = !(time % 2)
value = -1
ignorehitpause = 1

[State 15963, VelSet]
type = VelSet
trigger1 = 1
y = 0
ignorehitpause = 1

[State 15963, PosAdd]
type = PosAdd
trigger1 = 1
y = ((-120) - (pos y+Const(size.mid.pos.y)))/256
ignorehitpause = 1
