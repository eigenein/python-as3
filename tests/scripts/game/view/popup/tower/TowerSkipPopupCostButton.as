package game.view.popup.tower
{
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TowerSkipPopupCostButton extends ClipButton
   {
       
      
      public var tf_cost:ClipLabel;
      
      public var tf_label:ClipLabel;
      
      public var icon_gem:ClipSprite;
      
      public var layout_labels:ClipLayout;
      
      public function TowerSkipPopupCostButton()
      {
         tf_cost = new ClipLabel(true);
         tf_label = new ClipLabel(true);
         icon_gem = new ClipSprite();
         layout_labels = ClipLayout.horizontalMiddleCentered(4,tf_label,icon_gem,tf_cost);
         super();
      }
   }
}
