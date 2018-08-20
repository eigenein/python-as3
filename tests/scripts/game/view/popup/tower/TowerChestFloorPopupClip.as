package game.view.popup.tower
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TowerChestFloorPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var button_proceed:ClipButtonLabeled;
      
      public var button_proceed_chestsLeft:ClipButtonLabeled;
      
      public var chest:Vector.<TowerChestPanelClip>;
      
      public var tf_footer:ClipLabel;
      
      public var layout_footer:ClipLayout;
      
      public var layout_header:ClipLayout;
      
      public var chest_content:TowerChestFloorChestContentClip;
      
      public function TowerChestFloorPopupClip()
      {
         tf_header = new ClipLabel(true);
         button_proceed = new ClipButtonLabeled();
         button_proceed_chestsLeft = new ClipButtonLabeled();
         chest = new Vector.<TowerChestPanelClip>();
         tf_footer = new ClipLabel();
         layout_footer = ClipLayout.horizontalMiddleCentered(4,tf_footer);
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         chest_content = new TowerChestFloorChestContentClip();
         super();
      }
   }
}
