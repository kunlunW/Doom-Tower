Playerdate_SWITCH = 1 
Playerdate_magicdef =19
Yellowkey_itemid=1
Bluekey_itemid=2
Redkey_itemid=3
Greenkey_itemid=41



class Window_PlayerDate < Window_Base

  def initialize
    super(0, 0, 160, 480)#395)#192，416
    self.contents = Bitmap.new(width - 32, height - 32)
    self.z =210
    self.opacity=0
    self.back_opacity =255
    self.visible = false
    refresh
  end
  
  
  def refresh
    if $game_switches[50]
      self.x=0
    else
      self.x=480
    end
    self.contents.clear
    x=25
    x=30 if !$game_switches[27]
    y=75
    y=40 if !$game_switches[27]
    draw_actor_graphic($game_party.actors[0], 20, 40)
    self.contents.font.color = system_color
    self.contents.draw_text(40, 11, 25, 20, " ", 0) if $game_switches[36]
    self.contents.draw_text(100, 11, 25, 20, "F", 0)if $game_switches[36]
    self.contents.draw_text(0, 55, 50, 20, "Lv", 0)
    if $game_switches[42]
      if $game_variables[81][$game_variables[1]]!=0
        bitmap = Bitmap.new("Graphics/Pictures/up.png")
        self.contents.blt(40,55 , bitmap, Rect.new(0, 0, 20, 20))
      end
    end
    self.contents.draw_text(4, 65+x, 40, 20, "HP", 0)
    self.contents.draw_text(4, 65+x*2, 40, 20, "ATT", 0)
    self.contents.draw_text(4, 65+x*3, 40, 20,"DEF", 0)
    self.contents.draw_text(4, 65+x*4, 40, 20, "SHIELD", 0) if $game_switches[Playerdate_magicdef]
    self.contents.draw_text(4, 65+x*5, 40, 20, "SPEED", 0) if $game_switches[27]
    self.contents.draw_text(4, y+x*6, 40, 20, "EXP", 0)
    self.contents.draw_text(4, y+x*7, 40, 20, "$", 0)

    if $game_switches[26]
      bitmap = RPG::Cache.icon("101-01"))
      self.contents.blt(10, 280, bitmap, Rect.new(0, 0, 32, 32))    
      bitmap = RPG::Cache.icon("101-02"))
      self.contents.blt(10, 307, bitmap, Rect.new(0, 0, 32, 32))
      bitmap = RPG::Cache.icon("101-03"))
      self.contents.blt(10, 334, bitmap, Rect.new(0, 0, 32, 32))
      bitmap = RPG::Cache.icon("101-04") if $game_switches[43])
      self.contents.blt(10, 361, bitmap, Rect.new(0, 0, 32, 32)) if $game_switches[43]

    else
      self.contents.font.color = text_color(6)    
      self.contents.draw_text(8, 285, 50, 20, "Gold Key", 0)
      self.contents.font.color = text_color(4)    
      self.contents.draw_text(8, 313, 50, 20, "Sapphire Key", 0)
      self.contents.font.color = text_color(2)    
      self.contents.draw_text(8, 341, 50, 20, "Ruby Key", 0)
      self.contents.font.color = text_color(3)    
      self.contents.draw_text(8, 369, 50, 20, "Emerald Key", 0) if $game_switches[43]
    end
    
    @xgraphic=$game_party.actors[0]
    @xfloor=$game_variables[2]
    @xlevel=$game_actors[$game_variables[1]+1].level
    @xlevelup=$game_variables[$game_variables[1]+81] if $game_switches[42]
    @xlife=$game_actors[$game_variables[1]+1].hp
    @xattact=$game_actors[$game_variables[1]+1].str
    @xdefence=$game_actors[$game_variables[1]+1].dex
    @xmagicdef=$game_actors[$game_variables[1]+1].int if $game_switches[Playerdate_magicdef]
    @xspeed=$game_actors[$game_variables[1]+1].agi if $game_switches[27]
    @xexp= $game_actors[$game_variables[1]+1].exp
    @xgold=$game_party.gold
    @xyellowkey=$game_party.item_number(Yellowkey_itemid)
    @xbluekey=$game_party.item_number(Bluekey_itemid)
    @xredkey=$game_party.item_number(Redkey_itemid)
    @xgreenkey=$game_party.item_number(Greenkey_itemid) if $game_switches[43]
    @xpoison=$game_switches[13]
    @xpoor=$game_switches[15]
    @xcurse=$game_switches[16]
    @xslow=$game_switches[12]
    @xchange=$game_switches[50]
    
    
    self.contents.font.color = normal_color
    self.contents.draw_text(32, 0, 60, 45, @xfloor.to_s, 2) if $game_switches[36]
    self.contents.draw_text(40, 0, 80, 45, @xfloor.to_s, 2) if !$game_switches[36]
    
    self.contents.draw_text(50, 50, 65, 30, @xlevel.to_s, 2)
    self.contents.draw_text(43, 65+x, 72, 20,@xlife .to_s, 2)
    self.contents.draw_text(50, 65+x*2, 65, 20,@xattact .to_s, 2)
    self.contents.draw_text(50, 65+x*3, 65, 20,@xdefence .to_s, 2)
    self.contents.draw_text(50, 65+x*4, 65, 20,@xmagicdef .to_s, 2) if $game_switches[Playerdate_magicdef]
    self.contents.draw_text(50, 65+x*5, 65, 20,@xspeed .to_s, 2) if $game_switches[27]

    self.contents.draw_text(50, y+x*6, 65, 20,@xexp.to_s, 2)
    self.contents.draw_text(50, y+x*7, 65, 20, @xgold.to_s, 2)
    
    self.contents.font.color = text_color(6)
    self.contents.draw_text(75, 285, 25, 20, @xyellowkey.to_s, 2)
    self.contents.font.color = text_color(4)
    self.contents.draw_text(75, 313, 25, 20, @xbluekey .to_s, 2)
    self.contents.font.color = text_color(2)
    self.contents.draw_text(75, 341, 25, 20, @xredkey.to_s, 2)
    self.contents.font.color = text_color(3)
    self.contents.draw_text(75, 369, 25, 20, @xgreenkey.to_s, 2) if $game_switches[43]
    
    if $game_switches[13]
      if $game_switches[183]
        self.contents.font.color = text_color(3)
        self.contents.draw_text(8, 390, 30, 30, "Toxin".to_s, 0)
      end
    end
    self.contents.font.color = text_color(5)
    self.contents.draw_text(36, 390, 30, 30, "Frost".to_s, 0) if $game_switches[15]
    self.contents.font.color = text_color(4)
    self.contents.draw_text(64, 390, 30, 30, "Marked".to_s, 0) if $game_switches[16]
    self.contents.font.color = text_color(1)
    self.contents.draw_text(92, 390, 30, 30, "Slow".to_s, 0) if $game_switches[12]
    
    
    
  end
  
  def judge
    return true if @xgraphic!=$game_party.actors[0]
    return true if @xfloor!=$game_variables[2]
    return true if @xlevel!=$game_actors[$game_variables[1]+1].level
    return true if @xlevelup!=$game_variables[$game_variables[1]+81] if $game_switches[42]
    return true if @xlife!=$game_actors[$game_variables[1]+1].hp
    return true if @xattact!=$game_actors[$game_variables[1]+1].str
    return true if @xdefence!=$game_actors[$game_variables[1]+1].dex
    return true if @xmagicdef!=$game_actors[$game_variables[1]+1].int if $game_switches[Playerdate_magicdef]
    return true if @xspeed!=$game_actors[$game_variables[1]+1].agi if $game_switches[27]
    return true if @xexp!= $game_actors[$game_variables[1]+1].exp
    return true if @xgold!=$game_party.gold
    return true if @xyellowkey!=$game_party.item_number(Yellowkey_itemid)
    return true if @xbluekey!=$game_party.item_number(Bluekey_itemid)
    return true if @xredkey!=$game_party.item_number(Redkey_itemid)
    return true if @xgreenkey!=$game_party.item_number(Greenkey_itemid) if $game_switches[43]
    return true if @xpoison!=$game_switches[13]
    return true if @xpoor!=$game_switches[15]
    return true if @xcurse!=$game_switches[16]
    return true if @xslow!=$game_switches[12]
    return true if @xchange!=$game_switches[50]
    return false
  end

end

class Scene_Map
 alias xy_rpg_main main
 def main
   @Playerdate_window = Window_PlayerDate.new
   @Playerdate_window.x = $game_variables[105]
   xy_rpg_main
   @Playerdate_window .dispose
 end

 alias xy_rpg_update update
 def update
   xy_rpg_update
   if $game_switches[Playerdate_SWITCH]
     @Playerdate_window .visible = true     
     @Playerdate_window .refresh if @Playerdate_window.judge
   else
     @Playerdate_window .visible = false
   end
 end
end
