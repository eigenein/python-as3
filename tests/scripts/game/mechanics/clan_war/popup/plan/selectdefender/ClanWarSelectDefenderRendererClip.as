package game.mechanics.clan_war.popup.plan.selectdefender
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarSelectDefenderRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var bg_button:ClipButton;
      
      public function ClanWarSelectDefenderRendererClip()
      {
         tf_name = new ClipLabel();
         tf_power = new ClipLabel();
         player_portrait = new PlayerPortraitClip();
         bg_button = new ClipButton();
         super();
      }
   }
}
