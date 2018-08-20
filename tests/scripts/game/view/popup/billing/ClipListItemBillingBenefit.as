package game.view.popup.billing
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import feathers.layout.HorizontalLayoutData;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.billing.BillingBenefitValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   
   public class ClipListItemBillingBenefit extends ClipListItem
   {
       
      
      public var iconCheck:ClipSprite;
      
      public var icon_gem:ClipSprite;
      
      public var tf_value:ClipLabel;
      
      public var tf_text:ClipLabel;
      
      public var tf_text_multiline:ClipLabel;
      
      public var block_vip:BillingVipLevelBlock;
      
      public var tf_ending:ClipLabel;
      
      public var layout_item:ClipLayout;
      
      public function ClipListItemBillingBenefit()
      {
         iconCheck = new ClipSprite();
         icon_gem = new ClipSprite();
         tf_value = new ClipLabel(true);
         tf_text = new ClipLabel(true);
         tf_text_multiline = new ClipLabel();
         block_vip = new BillingVipLevelBlock();
         tf_ending = new ClipLabel(true);
         layout_item = ClipLayout.horizontalMiddleLeft(5,iconCheck,icon_gem,tf_value,tf_text_multiline,tf_text,block_vip,tf_ending);
         super();
      }
      
      override public function get customBounds() : Rectangle
      {
         layout_item.width = NaN;
         layout_item.validate();
         var _loc1_:Rectangle = _container.bounds;
         tf_text_multiline.maxWidth = 260;
         tf_text_multiline.width = NaN;
         tf_text_multiline.height = NaN;
         tf_text_multiline.validate();
         if(tf_text_multiline.visible && tf_text_multiline.text)
         {
            _loc1_.height = _loc1_.height + (tf_text_multiline.height - tf_text_multiline.assetHeight) * 0.9;
         }
         _loc1_.height = _loc1_.height + _loc1_.y * 2;
         _loc1_.y = 0;
         _loc1_.x = -_loc1_.x;
         _loc1_.width;
         return _loc1_;
      }
      
      override public function setData(param1:*) : void
      {
         var _loc2_:BillingBenefitValueObject = param1 as BillingBenefitValueObject;
         if(!_loc2_)
         {
            return;
         }
         icon_gem.graphics.visible = _loc2_.showGemIcon;
         tf_value.text = _loc2_.value;
         layout_item.width = NaN;
         if(_loc2_.showVip || _loc2_.showEnding)
         {
            tf_text.text = _loc2_.text;
            tf_text.visible = true;
            tf_text_multiline.visible = false;
            container.removeChild(tf_text_multiline);
         }
         else
         {
            tf_text_multiline.text = _loc2_.text;
            tf_text.visible = false;
            tf_text_multiline.visible = true;
         }
         if(_loc2_.showVip)
         {
            block_vip.graphics.visible = true;
            block_vip.setVip(_loc2_.vipLevel);
         }
         else
         {
            block_vip.graphics.visible = false;
         }
         if(_loc2_.showEnding)
         {
            tf_ending.graphics.visible = true;
            tf_ending.text = _loc2_.ending;
         }
         else
         {
            tf_ending.graphics.visible = false;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         tf_text_multiline.layoutData = new HorizontalLayoutData(NaN,100 * tf_text_multiline.assetHeight / layout_item.height);
         super.setNode(param1);
      }
   }
}
