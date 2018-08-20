package game.mechanics.clan_war.popup.leaguesandrewards
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.reward.RewardData;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class ClanWarLeaguesRewardRenderer extends GuiClipNestedContainer
   {
       
      
      public var title_tf:ClipLabel;
      
      public var reward_item_1:QuestRewardItemRenderer;
      
      public var reward_item_2:QuestRewardItemRenderer;
      
      public var reward_item_3:QuestRewardItemRenderer;
      
      public var layout_group:ClipLayout;
      
      public var reward_items:Vector.<QuestRewardItemRenderer>;
      
      public function ClanWarLeaguesRewardRenderer()
      {
         title_tf = new ClipLabel(true);
         reward_item_1 = new QuestRewardItemRenderer();
         reward_item_2 = new QuestRewardItemRenderer();
         reward_item_3 = new QuestRewardItemRenderer();
         layout_group = ClipLayout.horizontalMiddleCentered(10,title_tf,reward_item_1,reward_item_2,reward_item_3);
         reward_items = new Vector.<QuestRewardItemRenderer>();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            reward_items.push(this["reward_item_" + _loc2_] as QuestRewardItemRenderer);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < reward_items.length)
         {
            reward_items[_loc1_].dispose();
            _loc1_++;
         }
      }
      
      public function setData(param1:String, param2:RewardData) : void
      {
         var _loc3_:int = 0;
         if(param1 && param1.length)
         {
            title_tf.text = param1;
            var _loc4_:Boolean = true;
            title_tf.includeInLayout = _loc4_;
            title_tf.visible = _loc4_;
         }
         else
         {
            _loc4_ = false;
            title_tf.includeInLayout = _loc4_;
            title_tf.visible = _loc4_;
         }
         _loc3_ = 0;
         while(_loc3_ < reward_items.length)
         {
            if(param2 && param2.outputDisplay.length > _loc3_)
            {
               reward_items[_loc3_].data = param2.outputDisplay[_loc3_];
               reward_items[_loc3_].graphics.visible = true;
            }
            else
            {
               reward_items[_loc3_].data = null;
               reward_items[_loc3_].graphics.visible = false;
            }
            _loc3_++;
         }
      }
   }
}
