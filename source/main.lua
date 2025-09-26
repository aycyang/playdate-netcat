--[[ vim config just for this file

set makeprg=./build_and_run.sh
nnoremap <cr> :make<cr>

--]]

import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics

function fetchImg()
  print("creating request...")
  local req = playdate.network.http.new("raw.githubusercontent.com", 443, true, ":3")
  req:setRequestCompleteCallback(onResponse)
  req:setConnectTimeout(10)
  if not req:get("/aycyang/playdate-netcat/refs/heads/main/cat.txt") then
    print("get failed")
    return
  end
  print("fetching image...")
end

function dumpTable(t)
  for k, v in pairs(t) do
    print(k.."=", v)
  end
end

function onResponse(req, a, b)
  print("response")
  print(req)
  print(req:getResponseStatus())
  print(req:getProgress())
  print(req:getError())
  print(req:read())
end

function onConnect(err)
  if err then
    print(err)
    return
  end
  print("Playdate is online!")
  coroutine.resume(coroutine.create(fetchImg))
end

function init()
  playdate.network.setEnabled(true, onConnect)

  img = gfx.image.new("cat_smol_dither")
end

function playdate.update()
  local deltaTime = playdate.getElapsedTime()
  playdate.resetElapsedTime()

  gfx.setBackgroundColor(gfx.kColorBlack)
  gfx.clear()
  img:draw(0, 0)
end

init()
