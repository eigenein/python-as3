package game.view.popup.clan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.clan.ClanActivityRewardDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class ClanActivityRewardPopupRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_points:ClipLabel;
      
      public var icon_check:ClipSprite;
      
      public var icon_disabled:ClipSprite;
      
      public var icon_points:ClipSprite;
      
      public var reward_item:Vector.<RewardItemClip>;
      
      public function ClanActivityRewardPopupRendererClip()
      {
         tf_points = new ClipLabel();
         icon_check = new ClipSprite();
         icon_disabled = new ClipSprite();
         icon_points = new ClipSprite();
         reward_item = new Vector.<RewardItemClip>();
         super();
      }
      
      public function setData(param1:ClanActivityRewardDescription, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         tf_points.text = param1.activityPoints.toString();
         icon_check.graphics.visible = param2;
         icon_disabled.graphics.visible = !param2;
         var _loc3_:Vector.<InventoryItem> = param1.rewardDisplay;
         var _loc4_:int = reward_item.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_.length > _loc5_)
            {
               reward_item[_loc5_].data = _loc3_[_loc5_];
            }
            else
            {
               reward_item[_loc5_].graphics.visible = false;
            }
            _loc5_++;
         }
      }
      
      public function setCheck(param1:Boolean) : void
      {
         icon_check.graphics.visible = param1;
      }
   }
}
