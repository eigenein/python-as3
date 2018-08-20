package game.view.popup.mission
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipFactory;
   import feathers.controls.LayoutGroup;
   import feathers.data.ListCollection;
   import feathers.display.Scale9Image;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.mediator.gui.popup.mission.MissionEnterPopupMediator;
   import game.model.user.specialoffer.NY2018SecretRewardOfferViewOwner;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class MissionEnterPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
      
      public static const DROP_LIST_MAX_LENGTH:int = 5;
       
      
      private var mediator:MissionEnterPopupMediator;
      
      private var clip:MissionEnterRSXPopupGuiClip;
      
      private var enemyList:MissionEnterPopupEnemyList;
      
      private var dropList:MissionEnterPopupDropList;
      
      private var starDisplay:MissionStarDisplay;
      
      private var raidBlock:MissionEnterPopupRaidBlock;
      
      public function MissionEnterPopup(param1:MissionEnterPopupMediator)
      {
         super(param1);
         stashParams.windowName = "mission_enter";
         this.mediator = param1;
         param1.signal_eliteTriesUpdate.add(handler_eliteTriesUpdate);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.MISSION;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.TEAM_GATHER,clip.button_start);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc3_:RsxGameAsset = AssetStorage.rsx.popup_theme;
         var _loc1_:GuiClipFactory = new GuiClipFactory();
         clip = new MissionEnterRSXPopupGuiClip();
         _loc1_.create(clip,_loc3_.data.getClipByName("dialog_mission_start"));
         addChild(clip.graphics);
         width = int(clip.inst0_mainframe_64_64_2_2.graphics.width);
         height = int(clip.inst0_mainframe_64_64_2_2.graphics.height);
         clip.button_close.signal_click.add(close);
         enemyList = new MissionEnterPopupEnemyList();
         enemyList.width = clip.team_list_container.container.width;
         enemyList.height = clip.team_list_container.container.height;
         clip.team_list_container.container.addChild(enemyList);
         dropList = new MissionEnterPopupDropList(mediator);
         dropList.width = clip.item_list_container.container.width;
         dropList.height = clip.item_list_container.container.height;
         clip.item_list_container.container.addChild(dropList);
         starDisplay = clip.star_layout_container;
         raidBlock = new MissionEnterPopupRaidBlock(mediator);
         raidBlock.width = clip.raidpanel_layout_container.container.width;
         raidBlock.height = clip.raidpanel_layout_container.container.height;
         clip.raidpanel_layout_container.container.addChild(raidBlock);
         clip.button_start.initialize(Translate.translate("UI_DIALOG_MISSION_START_GO"),mediator.action_startMission);
         clip.tf_cost_label.text = Translate.translate("UI_DIALOG_MISSION_COST");
         clip.layout_elite_tries.visible = mediator.isElite && mediator.eliteTriesMax;
         if(mediator.isElite)
         {
            clip.tf_tries_label.text = Translate.translate("UI_DIALOG_MISSION_TRIES");
            clip.button_tries_add.signal_click.add(mediator.action_eliteRefill);
            (clip.inst0_mainframe_64_64_2_2.graphics as Scale9Image).textures = AssetStorage.rsx.popup_theme.getScale9Textures("evilframe_64_64_2_2",new Rectangle(64,64,2,2));
         }
         var _loc2_:MissionEnterPopupTitle = new MissionEnterPopupTitle(mediator.isElite,mediator.name);
         (clip.header_layout_container.container as LayoutGroup).layout = new HorizontalLayout();
         ((clip.header_layout_container.container as LayoutGroup).layout as HorizontalLayout).horizontalAlign = "center";
         clip.header_layout_container.container.addChild(_loc2_);
         if(clip.layout_secret)
         {
            if(mediator.worldIndex == 1)
            {
               switch(int(mediator.missionIndex) - 1)
               {
                  case 0:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_1"));
                     break;
                  case 1:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  default:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  default:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  default:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  default:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  default:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_2"));
                     break;
                  case 7:
                     mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_secret,this,"key_3"));
               }
            }
         }
         commitData();
      }
      
      private function commitData() : void
      {
         clip.tf_mission_desc.text = mediator.textDescription;
         clip.label_loot.text = Translate.translate("UI_DIALOG_MISSION_REWARDS");
         clip.label_enemies.text = Translate.translate("UI_DIALOG_MISSION_ENEMIES");
         clip.tf_cost.text = mediator.staminaCost.stamina.toString();
         enemyList.dataProvider = new ListCollection(mediator.enemyList);
         mediator.dropListProvider.whenDataUpdated(handler_updateDropList);
         raidBlock.visible = mediator.canRaid;
         starDisplay.setValue(mediator.stars,mediator.maxStars);
         if(mediator.isElite)
         {
            handler_eliteTriesUpdate();
         }
      }
      
      private function truncateDropLength(param1:Vector.<MissionDropValueObject>, param2:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_eliteTriesUpdate() : void
      {
         clip.button_tries_add.graphics.visible = mediator.eliteTriesAvailable == 0;
         clip.tf_tries.text = mediator.eliteTriesAvailable + "/" + mediator.eliteTriesMax;
      }
      
      private function handler_updateDropList(param1:Vector.<MissionDropValueObject>) : void
      {
         if(param1.length > 5)
         {
            truncateDropLength(param1,5);
         }
         dropList.dataProvider = new ListCollection(param1);
      }
   }
}
