package game.view.popup.arena.log
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   
   public class ArenaLogEntryPopupTeam extends GuiClipNestedContainer
   {
       
      
      public var tf_label_nickname:ClipLabel;
      
      public var hero_1:ArenaLogEntryPopupTeamItem;
      
      public var hero_2:ArenaLogEntryPopupTeamItem;
      
      public var hero_3:ArenaLogEntryPopupTeamItem;
      
      public var hero_4:ArenaLogEntryPopupTeamItem;
      
      public var hero_5:ArenaLogEntryPopupTeamItem;
      
      public var panels:Vector.<ArenaLogEntryPopupTeamItem>;
      
      public var level_yellow_inst0:ClipSprite;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function ArenaLogEntryPopupTeam()
      {
         tf_label_nickname = new ClipLabel();
         hero_1 = new ArenaLogEntryPopupTeamItem();
         hero_2 = new ArenaLogEntryPopupTeamItem();
         hero_3 = new ArenaLogEntryPopupTeamItem();
         hero_4 = new ArenaLogEntryPopupTeamItem();
         hero_5 = new ArenaLogEntryPopupTeamItem();
         panels = new Vector.<ArenaLogEntryPopupTeamItem>();
         level_yellow_inst0 = new ClipSprite();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
         panels = new <ArenaLogEntryPopupTeamItem>[hero_1,hero_2,hero_3,hero_4,hero_5];
      }
   }
}
