package game.view.popup.clan.activitystats
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.CheckBoxGuiToggleButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanReceiverGiftRendererClip extends ClipAnimatedContainer
   {
       
      
      public var bg_player:ClipSprite;
      
      public var line:ClipSprite;
      
      public var tf_name:ClipLabel;
      
      public var likes_layout_group:ClipLayout;
      
      public var gift_counter:ClanActivityStatsRendererGiftClip;
      
      public var checkBox:CheckBoxGuiToggleButton;
      
      public function ClanReceiverGiftRendererClip()
      {
         bg_player = new ClipSprite();
         line = new ClipSprite();
         tf_name = new ClipLabel();
         likes_layout_group = ClipLayout.horizontalMiddleLeft(2);
         gift_counter = new ClanActivityStatsRendererGiftClip();
         checkBox = new CheckBoxGuiToggleButton();
         super();
      }
   }
}
