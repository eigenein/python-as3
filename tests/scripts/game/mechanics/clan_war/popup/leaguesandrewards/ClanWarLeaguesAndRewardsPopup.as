package game.mechanics.clan_war.popup.leaguesandrewards
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarLeaguesAndRewardsPopupMediator;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanWarLeaguesAndRewardsPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanWarLeaguesAndRewardsPopupMediator;
      
      private var clip:ClanWarLeaguesAndRewardsPopupClip;
      
      public function ClanWarLeaguesAndRewardsPopup(param1:ClanWarLeaguesAndRewardsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         clip = AssetStorage.rsx.popup_theme.create(ClanWarLeaguesAndRewardsPopupClip,"clan_war_leagues_and_rewards");
         addChild(clip.graphics);
         clip.title_tf.text = Translate.translate("UI_DIALOG_CLANWAR_LEAGUES_AND_REWARDS");
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc5_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc5_.layout as VerticalLayout).horizontalAlign = "left";
         (_loc5_.layout as VerticalLayout).gap = 8;
         _loc5_.width = clip.list_container.graphics.width;
         _loc5_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc5_);
         var _loc3_:Vector.<ClanWarLeagueDescription> = mediator.leagues;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = AssetStorage.rsx.popup_theme.create(ClanWarLeaguesAndRewardsPopupRenderer,"clan_war_leagues_and_rewards_renderer");
            _loc2_.league = _loc3_[_loc4_];
            _loc5_.addChild(_loc2_.graphics);
            _loc4_++;
         }
      }
   }
}
