package game.view.popup.quest
{
   import feathers.controls.LayoutGroup;
   import feathers.controls.ToggleButton;
   import feathers.core.ToggleGroup;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.quest.QuestDescription;
   import game.mediator.gui.popup.quest.QuestListPopupMediator;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class QuestListPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var mediator:QuestListPopupMediator;
      
      private var toggle:ToggleGroup;
      
      private var list:QuestList;
      
      private var clip:QuestListPopupClip;
      
      public function QuestListPopup(param1:QuestListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_tabUpdate.add(onTabUpdate);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return mediator.tutorialNode;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_tutorialQuestTaskDisposed() : void
      {
         list.verticalScrollPolicy = "auto";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_quest_list();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new QuestList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.quest_list_container.container.width;
         list.height = clip.quest_list_container.container.height;
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         list.itemRendererType = QuestListItemRenderer;
         list.dataProvider = mediator.items;
         clip.quest_list_container.container.addChild(list);
         clip.button_close.signal_click.add(close);
         var _loc2_:PopupTitle = new PopupTitle(mediator.name);
         (clip.header_layout_container.container as LayoutGroup).layout = new HorizontalLayout();
         ((clip.header_layout_container.container as LayoutGroup).layout as HorizontalLayout).horizontalAlign = "center";
         clip.header_layout_container.container.addChild(_loc2_);
      }
      
      private function createButton(param1:String) : ToggleButton
      {
         var _loc2_:ToggleButton = new ToggleButton();
         _loc2_.label = param1;
         _loc2_.styleNameList.add("STYLE_TOGGLE_BUTTON_LABELED");
         return _loc2_;
      }
      
      private function onTabSelected(param1:Event) : void
      {
         mediator.action_selectTab((param1.currentTarget as ToggleGroup).selectedIndex);
      }
      
      private function onListRendererAdded(param1:Event, param2:QuestListItemRenderer) : void
      {
         param2.signal_select.add(onSelectSignal);
         param2.signal_farm.add(onFarmSignal);
         Tutorial.updateActionsFrom(this);
      }
      
      private function onListRendererRemoved(param1:Event, param2:QuestListItemRenderer) : void
      {
         param2.signal_select.remove(onSelectSignal);
         param2.signal_farm.remove(onFarmSignal);
         Tutorial.updateActionsFrom(this);
      }
      
      private function onSelectSignal(param1:PlayerQuestValueObject) : void
      {
         mediator.action_select(param1);
      }
      
      private function onFarmSignal(param1:PlayerQuestValueObject) : void
      {
         mediator.action_farm(param1);
      }
      
      private function onTabUpdate() : void
      {
         list.dataProvider = mediator.items;
         Tutorial.updateActionsFrom(this);
      }
   }
}
