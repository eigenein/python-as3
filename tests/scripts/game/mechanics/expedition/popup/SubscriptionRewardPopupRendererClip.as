package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.expedition.model.SubscriptionRewardPopupValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SubscriptionRewardPopupRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_desc:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var list_item:InventoryItemRenderer;
      
      public var layout_rewards:ClipLayout;
      
      public function SubscriptionRewardPopupRendererClip()
      {
         tf_desc = new ClipLabel();
         tf_name = new ClipLabel();
         list_item = new InventoryItemRenderer();
         layout_rewards = ClipLayout.verticalMiddleCenter(4,tf_name,tf_desc);
         super();
      }
      
      public function setData(param1:SubscriptionRewardPopupValueObject) : void
      {
         list_item.setData(param1.item);
         tf_desc.text = param1.desc;
         tf_name.text = param1.item.name;
      }
   }
}
