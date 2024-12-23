extends Node
class_name TimeStruct

signal ValueUpdate

var Hour: int = 0 : set = SetHour
var Min: int = 0 : set = SetMin
var Sec: int = 0 : set = SetSec

func _init(h = 0, m = 0, s = 0):
	Hour = h
	Min = m
	Sec = s

func SetHour(value: int):
	Hour = wrap(value, 0, 24)
	emit_signal("ValueUpdate")

func SetMin(value: int):
	var new_10
	var new_1
	
	if abs(Min - value) >= 10:
		new_10 = wrap(value / 10, 0, 6)
		new_1 = Min % 10
	else:
		new_10 = Min / 10
		new_1 = wrap(value % 10, 0, 10)
	
	Min = (new_10 * 10) + new_1
	emit_signal("ValueUpdate")

func SetSec(value: int):
	var new_10
	var new_1
	
	if abs(Sec - value) >= 10:
		new_10 = wrap(value / 10, 0, 6)
		new_1 = Sec % 10
	else:
		new_10 = Sec / 10
		new_1 = wrap(value % 10, 0, 10)
	
	Sec = (new_10 * 10) + new_1
	emit_signal("ValueUpdate")

# 자신의 시간을 초 단위로 반환
# 다른 씬에서도 사용 할 수 있도록 모듈화 함
func GetTotalSec() -> int:
	var ret: int = 0;
	
	ret += Hour * 3600
	ret += Min * 60
	ret += Sec
	
	return ret
