package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.MathUtil;
   import feathers.controls.List;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestDescription;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import org.osflash.signals.Signal;
   import starling.display.DisplayObjectContainer;
   
   public class SpecialQuestListItemRenderer extends ListItemRenderer implements ITutorialActionProvider
   {
       
      
      private var _clip:SpecialQuestListItemRendererClip;
      
      private var farmAnimation:SpecialQuestListItemRendererGlow;
      
      private var _signal_select:Signal;
      
      private var _signal_farm:Signal;
      
      private var oldRemoveAnimationProgress:Number;
      
      public function SpecialQuestListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerQuestValueObject);
         _signal_farm = new Signal(PlayerQuestValueObject);
      }
      
      override public function dispose() : void
      {
         data = null;
         Tutorial.removeActionsFrom(this);
         if(_clip)
         {
            _clip.dispose();
         }
         super.dispose();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_farm() : Signal
      {
         return _signal_farm;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            _loc2_.signal_progressUpdate.remove(handler_dataUpdate);
            _loc2_.removeAnimationProgress.unsubscribe(handler_removeAnimationProgress);
         }
         .super.data = param1;
         _loc2_ = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            _loc2_.signal_progressUpdate.add(handler_dataUpdate);
            _loc2_.removeAnimationProgress.onValue(handler_removeAnimationProgress);
         }
      }
      
      public function get clip() : SpecialQuestListItemRendererClip
      {
         return _clip;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 === param1)
         {
            .super.height = int(param1);
         }
         else
         {
            .super.height = param1;
         }
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:* = null;
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(data)
         {
            _loc3_ = DataStorage.quest.getQuestById((data as PlayerQuestValueObject).id);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_QUEST_FARM,_clip.button_finish,_loc3_);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_QUEST_GO,_clip.button_go,_loc3_);
         }
         return _loc2_;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         super.commitData();
         var _loc2_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            _clip.label_questTask.text = _loc2_.taskDescription;
            _clip.layout_reward.removeChildren();
            _loc1_ = _clip.reward_items.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(_loc2_.rewards && _loc2_.rewards.length > _loc3_)
               {
                  _clip.reward_items[_loc3_].setData(_loc2_.rewards[_loc3_]);
                  _clip.reward_items[_loc3_].graphics.visible = true;
                  _clip.slots[_loc3_].graphics.visible = false;
                  _clip.layout_reward.addChild(_clip.reward_items[_loc3_].graphics);
               }
               else
               {
                  _clip.reward_items[_loc3_].setData(null);
                  _clip.reward_items[_loc3_].graphics.visible = false;
                  _clip.slots[_loc3_].graphics.visible = true;
                  _clip.layout_reward.addChild(_clip.slots[_loc3_].graphics);
               }
               _loc3_++;
            }
            commitProgressData();
         }
         Tutorial.addActionsFrom(this);
      }
      
      protected function commitProgressData() : void
      {
         var _loc1_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(!_loc1_)
         {
            return;
         }
         if(_clip)
         {
            _clip.label_questTask.text = _loc1_.taskDescription + "\n" + "(" + _loc1_.progressCurrent + "/" + _loc1_.progressMax + ")";
            _clip.button_finish.graphics.visible = _loc1_.canFarm;
            _clip.button_go.graphics.visible = _loc1_.hasNavigator && !_loc1_.canFarm;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         farmAnimation = AssetStorage.rsx.popup_theme.create(SpecialQuestListItemRendererGlow,"special_quest_list_panel_animation");
         farmAnimation.graphics.touchable = false;
         farmAnimation.playback.stop();
         farmAnimation.playback.gotoAndStop(16);
         _clip = AssetStorage.rsx.popup_theme.create_special_quest_list_item();
         addChild(_clip.graphics);
         _clip.button_finish.label = Translate.translate("UI_DIALOG_QUEST_FARM");
         _clip.button_go.label = Translate.translate("UI_DIALOG_QUEST_INFO");
         _clip.button_finish.signal_click.add(buttonClickFarm);
         _clip.button_go.signal_click.add(buttonClickInfo);
      }
      
      private function handler_removeAnimationProgress(param1:Number) : void
      {
         var _loc3_:* = NaN;
         var _loc2_:* = NaN;
         if(oldRemoveAnimationProgress == 0 && param1 != 0)
         {
            addChild(farmAnimation.graphics);
            farmAnimation.playback.gotoAndPlay(0);
            farmAnimation.playback.playOnceAndHide();
         }
         oldRemoveAnimationProgress = param1;
         if(param1 > 0)
         {
            _loc3_ = 10;
            if(parent && parent.parent && parent.parent is List && (parent.parent as List).layout is VerticalLayout)
            {
               _loc3_ = Number(((parent.parent as List).layout as VerticalLayout).gap);
            }
            _loc2_ = 0.5;
            param1 = MathUtil.clamp(param1 - _loc2_,0,1 - _loc2_) / (1 - _loc2_);
            alpha = 1 - MathUtil.clamp(param1 - 0,0,0.4) / 0.4;
            height = _clip.layout_questTask.graphics.height * (1 - param1) - param1 * _loc3_;
            touchable = false;
         }
         else
         {
            if(farmAnimation.graphics.parent)
            {
               farmAnimation.graphics.removeFromParent();
               farmAnimation.playback.gotoAndStop(0);
            }
            alpha = 1;
            height = _clip.layout_questTask.graphics.height;
            touchable = true;
         }
      }
      
      private function buttonClickFarm() : void
      {
         _signal_farm.dispatch(data as PlayerQuestValueObject);
      }
      
      private function buttonClickInfo() : void
      {
         _signal_select.dispatch(data as PlayerQuestValueObject);
      }
      
      private function handler_dataUpdate(param1:PlayerQuestEntry) : void
      {
         commitProgressData();
      }
   }
}
