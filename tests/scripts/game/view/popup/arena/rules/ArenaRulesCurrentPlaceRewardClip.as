package game.view.popup.arena.rules
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   
   public class ArenaRulesCurrentPlaceRewardClip extends GuiClipNestedContainer
   {
       
      
      public var reward_item_1:ArenaRulesRewardItem;
      
      public var reward_item_2:ArenaRulesRewardItem;
      
      public var reward_item_3:ArenaRulesRewardItem;
      
      public var reward_item_4:ArenaRulesRewardItem;
      
      public var reward_item_5:ArenaRulesRewardItem;
      
      public var reward_items:Vector.<ArenaRulesRewardItem>;
      
      public var reward_layout:ClipLayout;
      
      public function ArenaRulesCurrentPlaceRewardClip()
      {
         reward_item_1 = new ArenaRulesRewardItem();
         reward_item_2 = new ArenaRulesRewardItem();
         reward_item_3 = new ArenaRulesRewardItem();
         reward_item_4 = new ArenaRulesRewardItem();
         reward_item_5 = new ArenaRulesRewardItem();
         reward_items = new <ArenaRulesRewardItem>[reward_item_1,reward_item_2,reward_item_3,reward_item_4,reward_item_5];
         reward_layout = ClipLayout.horizontalCentered(12,reward_item_1,reward_item_2,reward_item_3,reward_item_4,reward_item_5);
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = reward_items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            reward_items[_loc2_].dispose();
            _loc2_++;
         }
      }
   }
}
