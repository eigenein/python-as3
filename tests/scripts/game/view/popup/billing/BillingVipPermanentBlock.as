package game.view.popup.billing
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.core.Starling;
   
   public class BillingVipPermanentBlock extends GuiClipNestedContainer
   {
      
      private static const DEACTIVATION_X_OFFSET:Number = 20;
      
      private static const DEACTIVATION_DURATION:Number = 0.3;
       
      
      private var initialX:Number;
      
      public var vip_word:ClipSprite;
      
      public var tf_vip_permanent_label1:ClipLabel;
      
      public var tf_vip_permanent_label2:ClipLabel;
      
      public var layout:ClipLayout;
      
      public var layout_bottom:ClipLayout;
      
      public function BillingVipPermanentBlock()
      {
         vip_word = new ClipSprite();
         tf_vip_permanent_label1 = new ClipLabel(true);
         tf_vip_permanent_label2 = new ClipLabel(false);
         layout = ClipLayout.horizontalMiddleCentered(4,vip_word,tf_vip_permanent_label1);
         layout_bottom = ClipLayout.verticalMiddleCenter(0,tf_vip_permanent_label2);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         initialX = graphics.x;
         graphics.x = initialX - 20;
         graphics.alpha = 0;
      }
      
      public function tweenActivate() : void
      {
         Starling.juggler.removeTweens(graphics);
         Starling.juggler.tween(graphics,0.3,{
            "alpha":1,
            "x":initialX,
            "transition":"easeOut"
         });
      }
      
      public function tweenDeactivate() : void
      {
         Starling.juggler.removeTweens(graphics);
         Starling.juggler.tween(graphics,0.3,{
            "alpha":0,
            "x":initialX - 20,
            "transition":"easeOut"
         });
      }
   }
}
