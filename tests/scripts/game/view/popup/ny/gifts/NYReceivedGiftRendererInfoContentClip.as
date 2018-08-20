package game.view.popup.ny.gifts
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.refillable.CostButton;
   
   public class NYReceivedGiftRendererInfoContentClip extends GuiClipNestedContainer
   {
       
      
      public var reward_container:ClipLayout;
      
      public var tf_send:ClipLabel;
      
      public var btn_send:CostButton;
      
      public function NYReceivedGiftRendererInfoContentClip()
      {
         reward_container = ClipLayout.horizontalMiddleCentered(10);
         tf_send = new ClipLabel();
         btn_send = new CostButton();
         super();
      }
   }
}
