package game.view.gui.homescreen
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.homescreen.HomeScreenClanMenuMediator;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.clan.editicon.ClanIconClip;
   import starling.core.Starling;
   
   public class HomeScreenClanMenu extends LayoutGroup implements ITutorialActionProvider
   {
       
      
      private var icon:ClanIconClip;
      
      private var clip:HomeScreenClanMenuClip;
      
      private var mediator:HomeScreenClanMenuMediator;
      
      private var showToHomeScreenButton:Boolean = false;
      
      private var stateCanShowGlowAnimation:Boolean;
      
      public function HomeScreenClanMenu(param1:HomeScreenClanMenuMediator)
      {
         super();
         this.mediator = param1;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(clip.btn_clan.isEnabled)
         {
            if(showToHomeScreenButton)
            {
               _loc2_.addButton(TutorialNavigator.HOME_SCREEN,clip.btn_clan);
            }
            else
            {
               _loc2_.addButton(TutorialNavigator.CLAN_SCREEN,clip.btn_clan);
            }
         }
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.main_screen.create(HomeScreenClanMenuClip,"clan_button_block");
         addChild(clip.graphics);
         clip.btn_clan.label = Translate.translate("UI_MAINMENU_CLAN");
         clip.btn_clan.signal_click.add(mediator.action_clickClan);
         clip.btn_clan.redMarkerState = mediator.clanRedMarkerState;
         clip.btn_chat.label = Translate.translate("UI_MAINMENU_CHAT");
         clip.btn_chat.signal_click.add(mediator.action_clickChat);
         clip.btn_chat.redMarkerState = mediator.chatRedMarkerState;
         mediator.property_iconRequiresAttention.signal_update.add(handler_clanIconAttentionStateUpdate);
         mediator.signal_clanUpdate.add(handler_clanUpdate);
         mediator.signal_iconUpdate.add(handler_iconUpdate);
         mediator.property_isOnClanScreen.onValue(handler_isOnClanScreen);
         mediator.property_transitionIsInProgress.onValue(handler_transitionIsInProgress);
         Tutorial.addActionsFrom(this);
      }
      
      private function handler_transitionIsInProgress(param1:Boolean) : void
      {
         clip.btn_clan.isEnabled = !param1;
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_isOnClanScreen(param1:Boolean) : void
      {
         Starling.juggler.delayCall(updateClanButton,0.15,param1);
      }
      
      private function updateClanButton(param1:Boolean) : void
      {
         this.showToHomeScreenButton = param1;
         if(clip == null || clip.btn_clan == null)
         {
            return;
         }
         stateCanShowGlowAnimation = false;
         clip.btn_clan.animation_glow.graphics.visible = false;
         clip.btn_clan.to_home_screen.graphics.visible = param1;
         clip.btn_clan.clan_icon_bg.graphics.visible = !param1;
         if(param1)
         {
            if(icon)
            {
               icon.graphics.visible = false;
            }
            clip.btn_clan.default_flag.graphics.visible = false;
            clip.btn_clan.label = Translate.translate("UI_MAINMENU_TOWN");
         }
         else
         {
            if(mediator.icon)
            {
               if(!icon)
               {
                  icon = AssetStorage.rsx.clan_icons.createFlagClip();
                  var _loc2_:* = 0.5;
                  icon.graphics.scaleY = _loc2_;
                  icon.graphics.scaleX = _loc2_;
                  clip.btn_clan.layout_banner.addChild(icon.graphics);
               }
               icon.graphics.visible = true;
               clip.btn_clan.default_flag.graphics.visible = false;
               stateCanShowGlowAnimation = true;
               if(mediator.property_iconRequiresAttention.value)
               {
                  clip.btn_clan.animation_glow.graphics.visible = true;
               }
               AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.icon);
            }
            else
            {
               if(icon)
               {
                  icon.graphics.visible = false;
               }
               clip.btn_clan.default_flag.graphics.visible = true;
            }
            clip.btn_clan.label = Translate.translate("UI_MAINMENU_CLAN");
         }
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_clanUpdate() : void
      {
         updateClanButton(mediator.property_isOnClanScreen.value);
      }
      
      private function handler_iconUpdate() : void
      {
         if(mediator.property_isOnClanScreen.value)
         {
            AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.icon);
         }
      }
      
      private function handler_clanIconAttentionStateUpdate(param1:Boolean) : void
      {
         if(stateCanShowGlowAnimation && param1)
         {
            clip.btn_clan.animation_glow.graphics.visible = true;
         }
         else
         {
            clip.btn_clan.animation_glow.graphics.visible = false;
         }
      }
   }
}
