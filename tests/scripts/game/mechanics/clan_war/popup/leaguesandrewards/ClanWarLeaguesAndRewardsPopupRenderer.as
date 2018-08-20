package game.mechanics.clan_war.popup.leaguesandrewards
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarLeaguesAndRewardsPopupRenderer extends GuiClipNestedContainer
   {
       
      
      private var _league:ClanWarLeagueDescription;
      
      public var title_tf:ClipLabel;
      
      public var desc_tf:ClipLabel;
      
      public var rewards_week_tf:ClipLabel;
      
      public var rewards_tf:ClipLabel;
      
      public var layout_group:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function ClanWarLeaguesAndRewardsPopupRenderer()
      {
         title_tf = new ClipLabel();
         desc_tf = new ClipLabel();
         rewards_week_tf = new ClipLabel();
         rewards_tf = new ClipLabel();
         layout_group = ClipLayout.vertical(10);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function get league() : ClanWarLeagueDescription
      {
         return _league;
      }
      
      public function set league(param1:ClanWarLeagueDescription) : void
      {
         _league = param1;
         updateContent();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_group.height = NaN;
      }
      
      private function updateContent() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = null;
         layout_group.removeChildren();
         if(league)
         {
            title_tf.text = Translate.translate("LIB_CLANWAR_LEAGUE_NAME_" + league.id);
            switch(int(league.id) - 1)
            {
               case 0:
                  desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + league.id,league.divisionSize * league.divisions.length,league.divisionSize);
                  break;
               case 1:
                  desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + league.id,league.divisionSize * league.divisions.length,league.divisionSize,league.bestCount);
                  break;
               case 2:
                  desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + league.id,league.divisionSize * league.divisions.length,league.divisionSize,league.bestCount);
                  break;
               case 3:
                  desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + league.id,league.bestCount);
            }
            rewards_week_tf.text = Translate.translate("UI_DIALOG_CLANWAR_WEEK_REWARDS");
            rewards_tf.text = Translate.translate("UI_DIALOG_CLANWAR_REWARDS");
            layout_group.addChild(title_tf);
            layout_group.addChild(desc_tf);
            layout_group.addChild(rewards_week_tf);
            _loc4_ = 0;
            while(_loc4_ < league.divisions.length)
            {
               _loc5_ = league.divisions[_loc4_].id;
               _loc6_ = uint((league.divisions[_loc4_].id - 1) * league.divisionSize + 1);
               _loc3_ = uint(league.divisions[_loc4_].id * league.divisionSize);
               _loc2_ = "";
               if(league.divisionSize > 0)
               {
                  if(_loc6_ == _loc3_)
                  {
                     _loc2_ = Translate.translateArgs("UI_POPUP_ARENA_RULES_PLACE",_loc6_);
                  }
                  else
                  {
                     _loc2_ = Translate.translateArgs("UI_POPUP_ARENA_RULES_PLACE",_loc6_ + "-" + _loc3_);
                  }
               }
               _loc1_ = createRewardRenderer(_loc2_,league.divisions[_loc4_].weeklyReward);
               layout_group.addChild(_loc1_.graphics);
               _loc4_++;
            }
            layout_group.addChild(rewards_tf);
            _loc1_ = createRewardRenderer(Translate.translate("UI_DIALOG_CLANWAR_VICTORY_REWARD"),league.divisions[0].victoryReward);
            layout_group.addChild(_loc1_.graphics);
            _loc1_ = createRewardRenderer(Translate.translate("UI_DIALOG_CLANWAR_CHAMPIONS_REWARD"),league.divisions[0].championsReward);
            layout_group.addChild(_loc1_.graphics);
            _loc1_ = createRewardRenderer(Translate.translate("UI_DIALOG_CLANWAR_LOSERS_REWARD"),league.divisions[0].losersReward);
            layout_group.addChild(_loc1_.graphics);
            _loc1_ = createRewardRenderer(Translate.translate("UI_DIALOG_CLANWAR_DRAW_REWARD"),league.divisions[0].drawReward);
            layout_group.addChild(_loc1_.graphics);
            layout_group.validate();
            bg.graphics.height = layout_group.height + layout_group.y * 2;
         }
      }
      
      private function createRewardRenderer(param1:String, param2:RewardData) : ClanWarLeaguesRewardRenderer
      {
         var _loc3_:ClanWarLeaguesRewardRenderer = AssetStorage.rsx.popup_theme.create(ClanWarLeaguesRewardRenderer,"clan_war_leagues_reward_renderer");
         _loc3_.setData(param1,param2);
         return _loc3_;
      }
   }
}
