package game.mechanics.grand.popup.log
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class GrandLogInfoBattleClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var block_attacker:GrandLogInfoTeamClip;
      
      public var block_defender:GrandLogInfoTeamClip;
      
      public var button_chat:ClipButton;
      
      public var button_replay:ClipButton;
      
      public var buttons_layout:ClipLayout;
      
      public function GrandLogInfoBattleClip()
      {
         button_chat = new ClipButton();
         button_replay = new ClipButton();
         buttons_layout = ClipLayout.horizontalMiddleCentered(5,button_chat,button_replay);
         super();
      }
   }
}
