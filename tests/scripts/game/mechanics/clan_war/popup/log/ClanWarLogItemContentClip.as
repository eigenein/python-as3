package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.clan_war.popup.ClanWarEnemiesStateCip;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLogItemContentClip extends GuiClipNestedContainer
   {
       
      
      public var enemies:ClanWarEnemiesStateCip;
      
      public var tf_draw:ClipLabel;
      
      public var tf_current:ClipLabel;
      
      public var tf_attack_defeat:ClipLabel;
      
      public var tf_attack_victory:ClipLabel;
      
      public var tf_date:ClipLabel;
      
      public var tf_day:ClipLabel;
      
      public var button_select:ClipButtonLabeled;
      
      public var size:GuiClipLayoutContainer;
      
      public function ClanWarLogItemContentClip()
      {
         enemies = new ClanWarEnemiesStateCip();
         tf_draw = new ClipLabel();
         tf_current = new ClipLabel();
         tf_attack_defeat = new ClipLabel();
         tf_attack_victory = new ClipLabel();
         tf_date = new ClipLabel();
         tf_day = new ClipLabel();
         button_select = new ClipButtonLabeled();
         size = new GuiClipLayoutContainer();
         super();
      }
   }
}
