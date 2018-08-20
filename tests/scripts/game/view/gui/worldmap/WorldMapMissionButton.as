package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Node;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.mediator.gui.worldmap.WorldMapViewMissionValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.DataClipButton;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class WorldMapMissionButton extends DataClipButton implements ITutorialActionProvider, ITutorialButtonBoundsProvider
   {
       
      
      private var tooltipVO:TooltipVO;
      
      private var fadeTweenDuration:Number = 0.5;
      
      protected var selection_anim:WorldMapSelectionEffectAnimation;
      
      protected var selection_anim_tween:Tween;
      
      private var _isAvailable:Boolean;
      
      public var tf_id:ClipLabel;
      
      protected var _data:WorldMapViewMissionValueObject;
      
      protected var _index:int;
      
      public function WorldMapMissionButton()
      {
         tooltipVO = new TooltipVO(TooltipTextView,"");
         tf_id = new ClipLabel(true);
         super(WorldMapMissionButton);
         container.visible = false;
         createSelectedAnimation();
         selection_anim.graphics.alpha = 0;
         selection_anim.hide();
      }
      
      public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function get isAvailable() : Boolean
      {
         return _isAvailable;
      }
      
      public function get data() : WorldMapViewMissionValueObject
      {
         return _data;
      }
      
      public function set data(param1:WorldMapViewMissionValueObject) : void
      {
         if(_data == param1)
         {
            return;
         }
         if(_data)
         {
            _data.signal_progressUpdate.remove(handler_progressUpdate);
            _data.signal_updateIfCurrent.remove(handler_highlightUpdate);
         }
         _data = param1;
         container.visible = param1 != null;
         if(param1)
         {
            updateState();
            _data.signal_updateIfCurrent.add(handler_highlightUpdate);
            _data.signal_progressUpdate.add(handler_progressUpdate);
         }
         Tutorial.addActionsFrom(this);
         tooltipVO.hintData = _data.name;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index == param1)
         {
            return;
         }
         _index = param1;
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return 0;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return -35;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return 80;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(graphics);
         if(data && data.mission)
         {
            _loc2_.addButtonWithKey(TutorialNavigator.MISSION,this,data.mission);
         }
         return _loc2_;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         TooltipHelper.addTooltip(graphics,tooltipVO);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(param1 == "hover")
         {
            if(!_isAvailable)
            {
               return;
            }
            _loc3_ = true;
            _loc4_ = true;
         }
         else
         {
            _loc3_ = data && data.isCurrent;
         }
         updateSelectionAnim(_loc3_,_loc4_);
      }
      
      override public function click() : void
      {
         if(_isAvailable)
         {
            super.click();
         }
      }
      
      protected function updateSelectionAnim(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = param1;
         if(param1)
         {
            selection_anim.show(container);
         }
         if(!selection_anim_tween)
         {
            selection_anim_tween = new Tween(selection_anim.graphics,fadeTweenDuration);
         }
         selection_anim_tween.reset(selection_anim.graphics,fadeTweenDuration);
         selection_anim_tween.onComplete = handler_tweenComplete;
         selection_anim_tween.animate("alpha",_loc3_);
         Starling.juggler.add(selection_anim_tween);
         selection_anim.doubleSpeed = param2;
      }
      
      private function handler_tweenComplete() : void
      {
         if(selection_anim.graphics.alpha == 0)
         {
            if(container.contains(selection_anim.graphics))
            {
               container.removeChild(selection_anim.graphics);
            }
         }
      }
      
      protected function updateState() : void
      {
         _isAvailable = data && _data.available;
         graphics.useHandCursor = _isAvailable;
         updateSelectionAnim(_data.isCurrent,false);
      }
      
      protected function createSelectedAnimation() : void
      {
      }
      
      protected function updateStarCount() : void
      {
      }
      
      override protected function getClickData() : *
      {
         return this;
      }
      
      private function handler_highlightUpdate(param1:WorldMapViewMissionValueObject) : void
      {
         updateSelectionAnim(_data.isCurrent,false);
      }
      
      private function handler_progressUpdate(param1:WorldMapViewMissionValueObject) : void
      {
         updateStarCount();
         updateState();
      }
   }
}
