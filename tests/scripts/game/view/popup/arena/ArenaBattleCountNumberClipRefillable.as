package game.view.popup.arena
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArenaBattleCountNumberClipRefillable extends GuiClipNestedContainer
   {
       
      
      public var tf_current_battles:ClipLabel;
      
      public var tf_max_battles:ClipLabel;
      
      public var RoundButtBG_inst0:ClipSprite;
      
      public var btn_plus:ClipButton;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var layout:ClipLayout;
      
      public function ArenaBattleCountNumberClipRefillable()
      {
         tf_current_battles = new ClipLabel(true);
         tf_max_battles = new ClipLabel(true);
         RoundButtBG_inst0 = new ClipSprite();
         btn_plus = new ClipButton();
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout = ClipLayout.horizontalMiddleCentered(0,tf_current_battles,tf_max_battles);
         super();
      }
   }
}
