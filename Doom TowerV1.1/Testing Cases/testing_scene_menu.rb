class Scene_Menu

  def initialize(menu_index = 0)
    @menu_index = menu_index
  end

  def main

    s1 = "Enemies"
    s2 = "Items"
    s3 = "Save"
    s4 = "Load"
    if $record != nil and $record.mode == "Record"
      s5 = "Exit to menu"
    else
      s5 = "Restart"
    end
    s6 = " "
    @command_window = Window_Command.new(160, [s1, s2 ,s3 ,s4 ,s5,s6])#, s3, s4, s5, s6])
    @command_window.index = @menu_index

    if $game_system.save_disabled
      @command_window.disable_item(2)
    end
    @playtime_window = Window_PlayTime.new
    @playtime_window.x = 0
    @playtime_window.y = 224


    @steps_window = Window_Steps.new
    @steps_window.x = 0
    @steps_window.y = 320

    @gold_window = Window_Version.new
    @gold_window.x = 0
    @gold_window.y = 416
     
    @enemy_window = Window_EnemyDate.new
    @enemy_window.x = 160
    @enemy_window.y = 0
    
    Graphics.transition

    loop do
      
      Graphics.update
      Input.update
      update
      if $scene != self
        break
      end
    end
    Graphics.freeze
    @command_window.dispose
    @playtime_window.dispose
    @steps_window.dispose
    @gold_window.dispose
    @enemy_window.dispose
  end
  
  def update
    @command_window.update
    @playtime_window.update
    @steps_window.update
    @gold_window.update
    @enemy_window.update
    if @command_window.active
      update_command
      return
    end
    if @enemy_window.active
      update_status
      return
    end
  end
  
  def update_command
    if Input.trigger?(Input::B)
      $game_system.se_play($data_system.cancel_se)
      $scene = Scene_Map.new
      return
    end
    if Input.trigger?(Input::C)
      if $game_party.actors.size == 0 and @command_window.index < 4
        $game_system.se_play($data_system.buzzer_se)
        return
      end
      case @command_window.index
      
      when 0
        if $floorenemies==[]
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        $game_system.se_play($data_system.decision_se)
        @command_window.active = false
        @enemy_window.active = true
        @enemy_window.index = 0
        
      when 1  
        $game_system.se_play($data_system.decision_se)
        $scene = Scene_Item.new
      
      when 2 
        if $game_system.save_disabled
          $game_system.se_play($data_system.buzzer_se)
          return
        end
        $game_system.se_play($data_system.decision_se)
        $scene = Scene_Save.new
     
      when 3  
        $game_system.se_play($data_system.decision_se)
        $scene = Scene_Load2.new
      
      when 4 
        if $record != nil and $record.mode == "Record"
          $game_system.se_play($data_system.decision_se)
          Audio.bgm_fade(800)
          Audio.bgs_fade(800)
          Audio.me_fade(800)
          $scene = Scene_Title.new
        else
                    
        # 游戏重新开始
        # 载入数据库
        $data_mapname       = load_data("Data/MapInfos.rxdata")
        $data_actors        = load_data("Data/Actors.rxdata")
        $data_classes       = load_data("Data/Classes.rxdata")
        $data_skills        = load_data("Data/Skills.rxdata")
        $data_items         = load_data("Data/Items.rxdata")
        $data_weapons       = load_data("Data/Weapons.rxdata")
        $data_armors        = load_data("Data/Armors.rxdata")
        $data_enemies       = load_data("Data/Enemies.rxdata")
        $data_troops        = load_data("Data/Troops.rxdata")
        $data_states        = load_data("Data/States.rxdata")
        $data_animations    = load_data("Data/Animations.rxdata")
        $data_tilesets      = load_data("Data/Tilesets.rxdata")
        $data_common_events = load_data("Data/CommonEvents.rxdata")
        $data_system        = load_data("Data/System.rxdata")
        $game_system = Game_System.new
      
        Audio.bgm_stop
        Graphics.frame_count = 0
        $game_temp          = Game_Temp.new
        $game_system        = Game_System.new
        $game_switches      = Game_Switches.new
        $game_variables     = Game_Variables.new
        $game_self_switches = Game_SelfSwitches.new
        $game_screen        = Game_Screen.new
        $game_actors        = Game_Actors.new
        $game_party         = Game_Party.new
        $game_troop         = Game_Troop.new
        $game_map           = Game_Map.new
        $game_player        = Game_Player.new
        $game_party.setup_starting_members
        $game_map.setup($data_system.start_map_id)
        $game_player.moveto($data_system.start_x, $data_system.start_y)
        $game_player.refresh
        $game_map.autoplay
        $game_map.update
        $movedevents={}
        $scene = Scene_Map.new
        end
         
      when 5  
        $game_temp.common_event_id =19
        $scene = Scene_Map.new
      end
      return
    end
  end

  def update_status
    if Input.trigger?(Input::B)
      $game_system.se_play($data_system.cancel_se)
      @command_window.active = true
      @enemy_window.active = false
      @enemy_window.index = -1
      return
    end
    if Input.trigger?(Input::C)
      if $floorenemies!=[] and $game_party.item_number(4)>0
        $game_variables[13]=@enemy_window.index
        $scene=Scene_EnemyView.new
      end
      return
    end
  end
end