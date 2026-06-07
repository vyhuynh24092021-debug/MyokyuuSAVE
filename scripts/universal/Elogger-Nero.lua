-- =============================================================================
-- THE UNIVERSAL MASTER LOGGER SYSTEM (Everything & Everywhere)
-- =============================================================================
print(" [ELOGGER] Hệ thống quét toàn diện bắt đầu khởi chạy...")

-- Cấu hình hiển thị (Bật true nếu muốn log chi tiết hệ thống đó)
local CONFIG = {
	ANIMATION   = true, -- Hoạt ảnh, Keyframe
	AUDIO       = true, -- Sound, SoundGroups, Âm thanh
	EFFECTS     = true, -- Particle, Beam, Trail, Fire, Smoke, Sparkles
	PHYSICS     = true, -- Part tạo mới, Va chạm (Touched), Phá hủy, Vận tốc
	INTERACTION = true, -- ProximityPrompt, ClickDetector, Ghế ngồi (Seat)
	TWEENING    = true, -- Sự kiện Tween biến đổi thuộc tính
	INTERFACE   = true, -- Người chơi bấm UI (TextButton, ImageButton)
	DATA_VALUE  = true, -- Thay đổi giá trị của StringValue, IntValue, BoolValue...
}

local function getCleanPath(instance)
	local success, result = pcall(function() return instance:GetFullPath() end)
	return success and result or instance.Name
end



local function attachLogger(obj)
	if not obj or not obj:IsA("Instance") then return end


	if CONFIG.ANIMATION and obj:IsA("Animator") then
		obj.AnimationPlayed:Connect(function(track)
			local id = track.Animation and track.Animation.AnimationId or "N/A"
			print(string.format("🎬 [ANIM_PLAY] Tên: %s | ID: %s | Tại: %s", track.Name, id, getCleanPath(obj.Parent)))
			
			track.KeyframeReached:Connect(function(keyName)
				print(string.format("🔑 [ANIM_KEYFRAME] %s -> %s", track.Name, keyName))
			end)
			track.Stopped:Connect(function()
				print(string.format("⏹️ [ANIM_STOP] %s đã dừng.", track.Name))
			end)
		end)


	elseif CONFIG.AUDIO and obj:IsA("Sound") then
		obj.Played:Connect(function()
			print(string.format("🔊 [AUDIO_PLAY] %s | ID: %s | Vol: %.2f", obj.Name, obj.SoundId, obj.Volume))
		end)
		obj.Stopped:Connect(function()
			print(string.format("🔇 [AUDIO_STOP] %s", obj.Name))
		end)


	elseif CONFIG.EFFECTS and (obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Highlight")) then
		obj:GetPropertyChangedSignal("Enabled"):Connect(function()
			print(string.format("✨ [VFX_TOGGLE] [%s] %s -> Enabled: %s", obj.ClassName, obj.Name, tostring(obj.Enabled)))
		end)
		-- Riêng ParticleEmitter log thêm phát hạt đột ngột (Emit)
		if obj:IsA("ParticleEmitter") then
			obj.Changed:Connect(function(property)
				if property == "Rate" then
					print(string.format("💨 [PARTICLE_RATE] %s đổi mật độ hạt thành: %d", obj.Name, obj.Rate))
				end
			end)
		end


	elseif CONFIG.INTERACTION and obj:IsA("ProximityPrompt") then
		obj.Triggered:Connect(function(player)
			print(string.format("🤝 [PROXIMITY_TRIGGER] Người chơi [%s] kích hoạt: %s", player.Name, obj.Name))
		end)
	elseif CONFIG.INTERACTION and obj:IsA("ClickDetector") then
		obj.MouseClick:Connect(function(player)
			print(string.format("🖱️ [CLICK_DETECTOR] Người chơi [%s] click vào: %s", player.Name, obj.Parent.Name))
		end)
	elseif CONFIG.INTERACTION and obj:IsA("Seat") then
		obj:GetPropertyChangedSignal("Occupant"):Connect(function()
			local humanoid = obj.Occupant
			local name = humanoid and humanoid.Parent.Name or "Không ai"
			print(string.format("🪑 [SEAT_CHANGE] Ghế %s -> Người ngồi: %s", obj.Name, name))
		end)


	elseif CONFIG.INTERFACE and (obj:IsA("TextButton") or obj:IsA("ImageButton")) then
		obj.MouseButton1Click:Connect(function()
			print(string.format("💻 [UI_CLICK] Bấm nút: %s | Đường dẫn: %s", obj.Name, getCleanPath(obj)))
		end)


	elseif CONFIG.DATA_VALUE and (obj:IsA("StringValue") or obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("BoolValue") or obj:IsA("ObjectValue")) then
		obj.Changed:Connect(function(newValue)
			print(string.format("📊 [VALUE_CHANGED] Giá trị %s (%s) đổi thành: %s", obj.Name, obj.ClassName, tostring(newValue)))
		end)


	elseif CONFIG.PHYSICS and obj:IsA("BasePart") then
		-- Chỉ log những Part quan trọng có đặt tên riêng (Tránh làm lag nếu map quá nhiều part mặc định)
		if obj.Name ~= "Part" and obj.Name ~= "Terrain" then
			obj.Touched:Connect(function(otherPart)
				-- Chỉ log va chạm nếu đụng phải Nhân vật (Humanoid) để tránh rác output
				if otherPart.Parent:FindFirstChildOfClass("Humanoid") then
					print(string.format("💥 [PHYSICS_TOUCH] %s va chạm với Nhân vật: %s", obj.Name, otherPart.Parent.Name))
				end
			end)
		end
	end
end


-- 1. (Destroyed/Removed)
game.DescendantRemoving:Connect(function(descendant)
	if CONFIG.PHYSICS then
		print(string.format("🗑️ [INSTANCE_REMOVED] [%s] %s đã bị xóa khỏi game.", descendant.ClassName, descendant.Name))
	end
end)

-- 2.
for _, descendant in ipairs(game:GetDescendants()) do
	pcall(attachLogger, descendant)
end

-- 3.
game.DescendantAdded:Connect(function(descendant)
	if CONFIG.PHYSICS then
		print(string.format("� [INSTANCE_SPAWNED] [%s] Xuất hiện vật thể mới tên: %s", descendant.ClassName, descendant.Name))
	end
	pcall(attachLogger, descendant)
end)
