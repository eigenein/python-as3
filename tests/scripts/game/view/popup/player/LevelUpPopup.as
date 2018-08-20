package game.view.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import game.mediator.gui.popup.player.LevelUpPopupMediator;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   
   public class LevelUpPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var mediator:LevelUpPopupMediator;
      
      public function LevelUpPopup(param1:LevelUpPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "player_level_up:" + param1.level;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TEAM_LEVEL_UP;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         var _loc4_:LevelUpPopupClip = AssetStorage.rsx.popup_theme.create_dialog_level_up();
         addChild(_loc4_.graphics);
         _loc4_.tf_header.text = Translate.translate("UI_DIALOG_LEVEL_UP_TITLE");
         _loc4_.tf_level.text = mediator.level.toString();
         _loc4_.tf_label_energy.text = Translate.translate("UI_DIALOG_LEVEL_UP_ENERGY");
         _loc4_.tf_max_energy_before.text = mediator.stamina_prevLevel.toString();
         _loc4_.tf_max_energy.text = mediator.stamina_now.toString();
         _loc4_.tf_label_hero_lvl.text = Translate.translate("UI_DIALOG_LEVEL_UP_HERO_LEVEL");
         _loc4_.tf_max_hero_lvl_before.text = mediator.heroLevel_prevLevel.toString();
         _loc4_.tf_max_hero_lvl.text = mediator.heroLevel_now.toString();
         _loc4_.tf_label_energy_reward.text = Translate.translate("UI_DIALOG_LEVEL_UP_ENERGY_REWARD");
         _loc4_.tf_energy.text = mediator.energyReward.toString();
         _loc4_.okButton.label = Translate.translate("UI_DIALOG_LEVEL_UP_OK");
         _loc4_.okButton.signal_click.add(mediator.close);
         var _loc3_:Vector.<MechanicDescription> = mediator.displayedMechanics;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new LevelUpPopupMechanicRenderer();
            _loc1_.teamLevel = mediator.level;
            _loc1_.data = _loc3_[_loc2_];
            _loc4_.mechanics_group.layout_group.addChild(_loc1_);
            _loc2_++;
         }
         if(_loc3_.length == 0)
         {
            _loc4_.mechanics_group.container.visible = false;
            _loc4_.okButton.container.y = _loc4_.okButton.container.y - 100;
         }
         width = _loc4_.ribbon_154_154_2_inst0.graphics.width;
         height = _loc4_.okButton.graphics.y + _loc4_.okButton.graphics.height;
         whenDisplayed(playSound);
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.lvlUp.play();
      }
   }
}
