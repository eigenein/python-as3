package game.view.popup.team
{
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.display.Image;
   
   public class TeamGatherPopupHeroRenderer extends TeamGatherPopupTeamMemberRenderer implements ITutorialActionProvider
   {
       
      
      protected var checkIcon:Image;
      
      private var checkIconGroup:LayoutGroup;
      
      public function TeamGatherPopupHeroRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Tutorial.removeActionsFrom(this);
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:TeamGatherPopupHeroValueObject = data as TeamGatherPopupHeroValueObject;
         if(_loc2_ && !_loc2_.selected && !_loc2_.isEmpty && _loc2_.isAvailable)
         {
            _loc3_.addButton(TutorialNavigator.ACTION_GATHER_TEAM,button);
         }
         return _loc3_;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         Tutorial.addActionsFrom(this);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         checkIconGroup = new LayoutGroup();
         checkIcon = new Image(AssetStorage.rsx.popup_theme.getTexture("iconV"));
         var _loc1_:int = 46;
         checkIcon.y = _loc1_;
         checkIcon.x = _loc1_;
         checkIcon.touchable = false;
         addChild(checkIconGroup);
         checkIconGroup.addChild(checkIcon);
         checkIconGroup.includeInLayout = false;
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc2_:TeamGatherPopupHeroValueObject = param1 as TeamGatherPopupHeroValueObject;
         if(!_loc2_)
         {
            return;
         }
         button.isEnabled = _loc2_.isAvailable;
         checkIcon.visible = _loc2_ && _loc2_.selected;
         portrait.disabled = checkIcon.visible;
         portrait.visible = _loc2_.isOwned;
         emptySlot.visible = !portrait.visible;
      }
   }
}
