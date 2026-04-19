outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
workspace "PhyselEngine"
	architecture "x64"
	configurations { "Debug", "Release"}

	project "ImGui"
		kind "StaticLib"
		language "C++"
		cppdialect "C++20"
		staticruntime "off"

		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

		files{
			"vendor/imgui/imconfig.h",
            "vendor/imgui/imgui.h",
            "vendor/imgui/imgui.cpp",
            "vendor/imgui/imgui_draw.cpp",
            "vendor/imgui/imgui_internal.h",
            "vendor/imgui/imgui_tables.cpp",
            "vendor/imgui/imgui_widgets.cpp",
            "vendor/imgui/imstb_rectpack.h",
            "vendor/imgui/imstb_textedit.h",
            "vendor/imgui/imstb_truetype.h",
            "vendor/imgui/imgui_demo.cpp",
			"vendor/imgui/backends/imgui_impl_glfw.cpp",
            "vendor/imgui/backends/imgui_impl_glfw.h",
            "vendor/imgui/backends/imgui_impl_opengl3.cpp",
            "vendor/imgui/backends/imgui_impl_opengl3.h"
		}

		includedirs{
			"vendor/imgui",
			"vendor/glfw/include",
		}

		filter "configurations:Debug"
			symbols "on"

		filter "configurations:Release"
			optimize "on"


	project "GLFW"
		kind "StaticLib"
		language "C"

		targetdir("bin/" .. outputdir .. "/%{prj.name}")
		objdir("bin-int" .. outputdir .. "/%{prj.name}")

		files{
			"vendor/glfw/include/GLFW/glfw3.h",
		}

	project "Physel"
		kind "SharedLib"
		language "C++"
		cppdialect "C++20"

		files{
			"Physel/src/physel.h",
			"Physel/src/physel.cpp",
			"vendor/glad/src/glad.c",
		}

		includedirs {
			"vendor/glfw/include",
			"vendor/glad/include",
			"vendor/imgui",
			"vendor/imgui/backends",
		}

		links{
			"ImGui",
			"GLFW",
			"opengl32.lib",
		}