package game.mechanics.clan_war.popup.plan.building
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class ClanWarBuildingPlanPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_desc:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var scroll_bar:GameScrollBar;
      
      public var list:GameScrolledList;
      
      public var tf_warning:ClipLabel;
      
      public function ClanWarBuildingPlanPopupClip()
      {
         button_close = new ClipButton();
         tf_desc = new ClipLabel();
         tf_header = new ClipLabel();
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         scroll_bar = new GameScrollBar();
         list = new GameScrolledList(scroll_bar,gradient_top.graphics,gradient_bottom.graphics);
         tf_warning = new ClipLabel();
         super();
      }
   }
}
