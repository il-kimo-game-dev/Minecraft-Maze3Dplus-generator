package com.ilkimo.minecraft.mod.maze

import net.fabricmc.api.ModInitializer
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback
import net.minecraft.commands.Commands
import net.minecraft.network.chat.Component
import net.minecraft.resources.Identifier
import org.slf4j.LoggerFactory

object MinecraftMaze3DplusGenerator : ModInitializer {
	const val MOD_ID: String = "minecraft-maze3dplus-generator"

	private val LOGGER = LoggerFactory.getLogger(MOD_ID)

	override fun onInitialize() {
		// This code runs as soon as Minecraft is in a mod-load-ready state.
		// However, some things (like resources) may still be uninitialized.
		// Proceed with mild caution.

		LOGGER.info("Maze3Dplus generator loaded on the server!")

		CommandRegistrationCallback.EVENT.register { dispatcher, _, _ ->
			dispatcher.register(
				Commands.literal("maze").executes { ctx ->
					ctx.source.sendSuccess({ Component.literal("Maze3Dplus is alive!") }, false)
					1
				}
			)
		}
	}

	fun id(path: String): Identifier
		= Identifier.fromNamespaceAndPath(MOD_ID, path)
}
