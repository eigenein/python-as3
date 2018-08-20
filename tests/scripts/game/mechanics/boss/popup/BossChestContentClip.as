package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.billing.BillingVipLevelBlock;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   import starling.filters.ColorMatrixFilter;
   
   public class BossChestContentClip extends GuiClipNestedContainer
   {
       
      
      private var _tintIntensity:Number = 0;
      
      private var filterColorMatrix:Vector.<Number>;
      
      public var tf_reward_desc:ClipLabel;
      
      public var item_reward_1:PlayerInventoryItemTile;
      
      public var item_reward_2:PlayerInventoryItemTile;
      
      public var item_reward_3:PlayerInventoryItemTile;
      
      public var tf_label_reward_1:ClipLabel;
      
      public var tf_label_reward_2:ClipLabel;
      
      public var tf_label_reward_3:ClipLabel;
      
      public var tf_label_vip_reward_gold:ClipLabel;
      
      public var gold_bonus_vip_lvl:BillingVipLevelBlock;
      
      public var layout_vip_gold:ClipLayout;
      
      public function BossChestContentClip()
      {
         filterColorMatrix = new <Number>[0,0,0,0,255,0,0,0,0,255,0,0,0,0,255,0,0,0,1,0];
         tf_reward_desc = new ClipLabel();
         item_reward_1 = new PlayerInventoryItemTile();
         item_reward_2 = new PlayerInventoryItemTile();
         item_reward_3 = new PlayerInventoryItemTile();
         tf_label_reward_1 = new ClipLabel();
         tf_label_reward_2 = new ClipLabel();
         tf_label_reward_3 = new ClipLabel();
         tf_label_vip_reward_gold = new ClipLabel(true);
         gold_bonus_vip_lvl = new BillingVipLevelBlock();
         layout_vip_gold = ClipLayout.horizontalMiddleCentered(2,gold_bonus_vip_lvl,tf_label_vip_reward_gold);
         super();
      }
      
      public function get tintIntensity() : Number
      {
         return _tintIntensity;
      }
      
      public function set tintIntensity(param1:Number) : void
      {
         var _loc2_:* = null;
         _tintIntensity = param1;
         if(param1 > 0)
         {
            if(!graphics.filter)
            {
               _loc2_ = new ColorMatrixFilter();
               graphics.filter = _loc2_;
            }
            else
            {
               _loc2_ = (graphics.filter as ColorMatrixFilter).reset();
               _loc2_.reset();
            }
            var _loc3_:* = 1 - param1;
            filterColorMatrix[12] = _loc3_;
            _loc3_ = _loc3_;
            filterColorMatrix[6] = _loc3_;
            filterColorMatrix[0] = _loc3_;
            _loc3_ = 255 * param1;
            filterColorMatrix[14] = _loc3_;
            _loc3_ = _loc3_;
            filterColorMatrix[9] = _loc3_;
            filterColorMatrix[4] = _loc3_;
            _loc2_.matrix = filterColorMatrix;
         }
         else if(graphics.filter)
         {
            graphics.filter.dispose();
            graphics.filter = null;
         }
      }
   }
}
