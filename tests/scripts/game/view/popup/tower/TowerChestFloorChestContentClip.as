package game.view.popup.tower
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class TowerChestFloorChestContentClip extends GuiClipNestedContainer
   {
       
      
      public var tf_reward_desc:ClipLabel;
      
      public var item_reward_1:RewardItemClip;
      
      public var item_reward_2:RewardItemClip;
      
      public var item_reward_3:RewardItemClip;
      
      public var icon_check_gold:GuiAnimation;
      
      public var icon_check_coin:GuiAnimation;
      
      public var icon_check_item:GuiAnimation;
      
      public var tf_label_reward_1:ClipLabel;
      
      public var tf_label_reward_2:ClipLabel;
      
      public var tf_label_reward_3:ClipLabel;
      
      public var tf_label_vip6_text:SpecialClipLabel;
      
      public var tf_label_vip_status:SpecialClipLabel;
      
      public var tf_label_vip_reward_gold:ClipLabel;
      
      public var icon_gold:ClipSprite;
      
      public var layout_vip_gold:ClipLayout;
      
      public function TowerChestFloorChestContentClip()
      {
         tf_reward_desc = new ClipLabel();
         item_reward_1 = new RewardItemClip();
         item_reward_2 = new RewardItemClip();
         item_reward_3 = new RewardItemClip();
         icon_check_gold = new GuiAnimation();
         icon_check_coin = new GuiAnimation();
         icon_check_item = new GuiAnimation();
         tf_label_reward_1 = new ClipLabel();
         tf_label_reward_2 = new ClipLabel();
         tf_label_reward_3 = new ClipLabel();
         tf_label_vip6_text = new SpecialClipLabel();
         tf_label_vip_status = new SpecialClipLabel();
         tf_label_vip_reward_gold = new ClipLabel(true);
         icon_gold = new ClipSprite();
         layout_vip_gold = ClipLayout.horizontalMiddleCentered(2,tf_label_vip_reward_gold,icon_gold);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         icon_check_gold.graphics.touchable = false;
         icon_check_coin.graphics.touchable = false;
         icon_check_item.graphics.touchable = false;
      }
   }
}
