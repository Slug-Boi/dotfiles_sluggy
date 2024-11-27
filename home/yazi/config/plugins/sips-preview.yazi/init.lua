local M = {}

function M:peek()
    local start, cache = os.clock(), ya.file_cache(self)
    if not cache or self:preload() ~= 1 then
        ya.sleep(math.max(0, PREVIEW.image_delay / 1000 + start - os.clock()))
        ya.manager_emit("peek", {0, only_if = self.file.url})
        return
    end

    ya.image_show(cache, self.area)
    ya.preview_widgets(self, {})
end

function M:seek() end

function M:preload()
    local cache = ya.file_cache(self)
    if not cache or fs.cha(cache) then
        return 1
    end

    local output = Command("sips")
            :args({ "-g", "pixelHeight", "-g", "pixelWidth", tostring(self.file.url) })
            :stdout(Command.PIPED)
            :stderr(Command.PIPED)
            :output()

    if not output then
        return 0
    elseif not output.status.success then
        return 0
    end

    local height = tonumber(string.match(output.stdout, "pixelHeight: (%d+)"))
    local width = tonumber(string.match(output.stdout, "pixelWidth: (%d+)"))

    local max_width = (width / height) >= (PREVIEW.max_width / PREVIEW.max_height)

    local child, code = Command("sips"):args({
        "-s", "format", "jpeg",
        "-s", "formatOptions", tostring(PREVIEW.image_quality),
        max_width and "--resampleWidth" or "--resampleHeight",
        max_width and tostring(PREVIEW.max_width) or tostring(PREVIEW.max_height),
        tostring(self.file.url),
        "-o", tostring(cache)
    }):spawn()

    if not child then
        ya.err("spawn `sips` command returns " .. tostring(code))
        return 0
    end

    local status = child:wait()
    return status and status.success and 1 or 2
end

return M

