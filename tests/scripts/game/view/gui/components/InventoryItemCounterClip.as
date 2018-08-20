package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class InventoryItemCounterClip extends GuiClipNestedContainer
   {
       
      
      private var _maxWidth:Number;
      
      private var _tf_amount_y:Number;
      
      public var tf_amount:ClipLabel;
      
      public var numBG_8_8_1_inst0:GuiClipScale3Image;
      
      public function InventoryItemCounterClip()
      {
         super();
         tf_amount = new ClipLabel(true);
         numBG_8_8_1_inst0 = new GuiClipScale3Image();
      }
      
      public function set text(param1:String) : void
      {
         tf_amount.text = param1;
         updateSize();
      }
      
      public function set maxWidth(param1:Number) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 9;
         this._maxWidth = param1 - 9;
         updateSize();
      }
      
      public function updateSize() : void
      {
         var _loc3_:* = NaN;
         _loc3_ = 0.75;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         _loc4_ = 5;
         var _loc1_:int = 0;
         _loc1_ = 7;
         if(_maxWidth && tf_amount.text)
         {
            tf_amount.resetSize();
            _loc2_ = _tf_amount_y + tf_amount.height * _loc3_;
            if(tf_amount.width > _maxWidth)
            {
               tf_amount.adjustSizeToFitWidth(_maxWidth);
               tf_amount.width = NaN;
               tf_amount.validate();
            }
            if(tf_amount.width > _maxWidth - 5)
            {
               tf_amount.x = -tf_amount.width - 2;
            }
            else
            {
               tf_amount.x = -tf_amount.width - 4;
            }
            tf_amount.y = Math.round(_loc2_ - tf_amount.height * _loc3_);
         }
         numBG_8_8_1_inst0.image.x = tf_amount.x - 5;
         numBG_8_8_1_inst0.image.width = tf_amount.width + 5 + 7;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         _tf_amount_y = tf_amount.y;
      }
   }
}
