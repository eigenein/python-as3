package game.battle.gui
{
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.LayoutFactory;
   import starling.display.Image;
   
   public class BattleGuiRewardBlock
   {
       
      
      public const layoutGroup:LayoutGroup = LayoutFactory.horizontal_verticalAligned(5,"middle");
      
      private var goldCount:int;
      
      private var gold_label:Label;
      
      private var chest_label:Label;
      
      private var chestCount:int;
      
      public function BattleGuiRewardBlock()
      {
         super();
         layoutGroup.x = 15;
         layoutGroup.y = 15;
         var _loc2_:Image = new Image(AssetStorage.rsx.popup_theme.getTexture("icon_gold_coin"));
         layoutGroup.addChild(_loc2_);
         gold_label = GameLabel.size24("0");
         layoutGroup.addChild(gold_label);
         var _loc1_:Image = new Image(AssetStorage.rsx.battle_interface.getTexture("icon_chest"));
         layoutGroup.addChild(_loc1_);
         chest_label = GameLabel.size24("0");
         layoutGroup.addChild(chest_label);
      }
      
      public function add(param1:RewardData) : void
      {
         var _loc4_:int = param1.gold;
         if(_loc4_)
         {
            goldCount = goldCount + _loc4_;
            gold_label.text = String(goldCount);
         }
         var _loc2_:Array = param1.inventoryCollection.toArray();
         _loc2_.concat(param1.fragmentCollection.toArray());
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc5_ = _loc5_ + _loc3_.amount;
         }
         if(_loc5_ > 0)
         {
            chestCount = chestCount + _loc5_;
            chest_label.text = chestCount.toString();
         }
      }
   }
}
