package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLogItemFooterClip extends GuiClipNestedContainer
   {
       
      
      public var tf_result:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var tf_decider:ClipLabel;
      
      public var icon_VP:ClipSprite;
      
      public var layout:ClipLayout;
      
      public var size:GuiClipLayoutContainer;
      
      public function ClanWarLogItemFooterClip()
      {
         tf_result = new ClipLabel(true);
         tf_points = new ClipLabel(true);
         tf_place = new ClipLabel();
         tf_decider = new ClipLabel();
         icon_VP = new ClipSprite();
         layout = ClipLayout.horizontalMiddleCentered(1,tf_result,icon_VP,tf_points);
         size = new GuiClipLayoutContainer();
         super();
      }
   }
}
