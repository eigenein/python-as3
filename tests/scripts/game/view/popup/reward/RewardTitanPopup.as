package game.view.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.posting.ActionType;
   import engine.context.platform.social.posting.PostUtils;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.assets.storage.AssetStorage;
   import game.battle.view.hero.AnimationIdent;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.model.GameModel;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.stat.Stash;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class RewardTitanPopup extends ClipBasedPopup implements ITutorialNodePresenter, ITutorialActionProvider
   {
       
      
      private var _canShare:Boolean;
      
      private var _titanDesc:TitanDescription;
      
      private var _shards:int;
      
      private var clip:RewardHeroPopupClip;
      
      private var heroPreview:HeroPreview;
      
      public function RewardTitanPopup(param1:TitanDescription, param2:int = 0)
      {
         _canShare = GameModel.instance.actionManager.platform.storyPostEnabled;
         super(null);
         this._shards = param2;
         this._titanDesc = param1;
      }
      
      public function get playerTitan() : PlayerTitanEntry
      {
         return GameModel.instance.player.titans.getById(_titanDesc.id);
      }
      
      public function get titanDesc() : TitanDescription
      {
         return _titanDesc;
      }
      
      public function get shards() : int
      {
         return _shards;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.REWARD_HERO;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Boolean = false;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_reward_titan();
         addChild(clip.graphics);
         var _loc7_:* = shards > 0;
         clip.tf_hero_name.text = titanDesc.name;
         if(playerTitan)
         {
            _loc4_ = playerTitan.star.star.id;
         }
         else
         {
            _loc4_ = titanDesc.startingStar.star.id;
         }
         if(_loc7_)
         {
            clip.chest_block.graphics.visible = false;
            _loc1_ = new InventoryFragmentItem(titanDesc,shards);
            clip.tf_header.text = Translate.translate("UI_DIALOG_REWARD_TITAN_HDR_FRAGMENTS");
            clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_REWARD_TITAN_FRAGMENT_COUNT",_loc1_.amount);
            _loc3_ = AssetStorage.rsx.popup_theme.create(PlayerInventoryItemTile,"inventory_tile");
            addChild(_loc3_.graphics);
            _loc3_.graphics.touchable = false;
            clip.layout_fragment_btns.addChildAt(_loc3_.graphics,0);
            _loc3_.data = _loc1_;
            clip.star_epic.container.visible = false;
         }
         else
         {
            clip.tf_caption.visible = false;
            clip.fragment_container.graphics.visible = false;
            clip.tf_header.text = Translate.translate("UI_DIALOG_REWARD_TITAN_HDR");
            clip.star_layout_container.removeChildren();
            clip.star_epic.container.visible = _loc4_ == 6;
            if(_loc4_ < 6)
            {
               _loc6_ = 1;
               while(_loc6_ <= _loc4_)
               {
                  _loc2_ = new Image(_loc6_ <= _loc4_?AssetStorage.rsx.popup_theme.getTexture("bigstarIcon"):AssetStorage.rsx.popup_theme.getTexture("bigstaremptyIcon"));
                  clip.star_layout_container.addChild(_loc2_);
                  _loc6_++;
               }
            }
            _loc5_ = false;
            clip.chest_block.graphics.visible = _loc5_;
            if(_loc5_)
            {
               clip.chest_block.tf_chest_label.text = Translate.translate("UI_DIALOG_HERO_CHEST_TEXT");
               clip.chest_block.button.label = Translate.translate("UI_DIALOG_HERO_CHEST_GO");
               clip.chest_block.button.signal_click.add(handler_gotoChest);
            }
         }
         height = clip.layout_fragment_btns.y + clip.layout_fragment_btns.height;
         width = clip.ribbon_154_154_2_inst0.graphics.width;
         heroPreview = new HeroPreview();
         clip.hero_container.container.addChild(heroPreview.graphics);
         heroPreview.loadTitan(titanDesc);
         heroPreview.scheduleAnimation(AnimationIdent.POSE,"POSE_INTRO");
         if(!_canShare || shards != 0)
         {
            clip.okButton.signal_click.add(handler_close);
            clip.okButton.label = Translate.translate("UI_POPUP_HERO_UPGRADE_OK");
            clip.button_close.graphics.visible = false;
         }
         else
         {
            clip.okButton.label = Translate.translate("UI_DIALOG_REWARD_HERO_SHARE");
            clip.okButton.signal_click.add(handler_share);
            clip.button_close.signal_click.add(handler_close);
         }
         Tutorial.updateActionsFrom(this);
         whenDisplayed(playSound);
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.heroUp.play();
      }
      
      private function handler_gotoChest() : void
      {
         handler_close();
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CHEST,Stash.click("chest",stashParams));
      }
      
      private function handler_close() : void
      {
         close();
         HeroRewardPopupHandler.instance.release();
      }
      
      private function handler_share() : void
      {
         var _loc1_:StoryPostParams = PostUtils.fillTitanPostParams(titanDesc,ActionType.OBTAIN);
         GameModel.instance.actionManager.platform.storyPost(_loc1_);
         handler_close();
      }
   }
}
