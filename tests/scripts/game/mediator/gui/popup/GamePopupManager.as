package game.mediator.gui.popup
{
   import engine.debug.ClickLoger;
   import feathers.core.DefaultPopUpManager;
   import feathers.core.FocusManager;
   import feathers.core.IFeathersControl;
   import feathers.core.IFocusManager;
   import feathers.core.IValidating;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.stash.StashEventDescription;
   import game.mediator.gui.component.PopupOverlay;
   import game.mediator.gui.popup.queue.PopupQueueManager;
   import game.mediator.gui.popup.resourcepanel.PopupResourcePanelMediator;
   import game.model.GameModel;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.PopupBase;
   import game.view.popup.common.IModalPopup;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   
   public class GamePopupManager extends DefaultPopUpManager
   {
      
      private static var _instance:GamePopupManager;
      
      private static var _signal_popupAdded:Signal = new Signal();
      
      private static var _signal_popupRemoved:Signal = new Signal();
       
      
      private var modalPopupQueue:Vector.<DisplayObject>;
      
      private var overlay:DisplayObject;
      
      private var _resizeEventDispatcher:EventDispatcher;
      
      private var _stageWidth:Number;
      
      private var _stageHeight:Number;
      
      private var _popupQueue:PopupQueueManager;
      
      private var _resourcePanel:PopupResourcePanelMediator;
      
      public function GamePopupManager()
      {
         _popupQueue = new PopupQueueManager();
         super();
         _instance = this;
         overlayFactory = popupOverlay;
         modalPopupQueue = new Vector.<DisplayObject>();
         _resourcePanel = new PopupResourcePanelMediator();
      }
      
      public static function get instance() : GamePopupManager
      {
         return _instance;
      }
      
      public static function get signal_popupAdded() : Signal
      {
         return _signal_popupAdded;
      }
      
      public static function get signal_popupRemoved() : Signal
      {
         return _signal_popupRemoved;
      }
      
      public static function tryCloseTopMost() : void
      {
         if(_instance)
         {
            _instance._tryCloseTopMost();
         }
      }
      
      public static function closeAll() : void
      {
         if(_instance)
         {
            _instance._closeAll();
         }
      }
      
      public static function add(param1:PopupMediator) : void
      {
         _instance.addPopUp(param1.createPopup());
      }
      
      public static function queuePopup(param1:PopupBase, param2:int = 1000) : void
      {
         (PopUpManager.forStarling(Starling.current) as GamePopupManager)._popupQueue.queuePopup(param1,param2);
      }
      
      public static function unqueuePopup(param1:PopupBase) : void
      {
         (PopUpManager.forStarling(Starling.current) as GamePopupManager)._popupQueue.unqueuePopup(param1);
      }
      
      public function get popupCount() : int
      {
         return _popUps.length;
      }
      
      public function get resourcePanel() : PopupResourcePanelMediator
      {
         return _resourcePanel;
      }
      
      protected function get stageWidth() : Number
      {
         if(_root.stage)
         {
            _stageWidth = _root.stage.stageWidth;
            return _root.stage.stageWidth;
         }
         return _stageWidth;
      }
      
      protected function get stageHeight() : Number
      {
         if(_root.stage)
         {
            _stageHeight = _root.stage.stageHeight;
            return _root.stage.stageHeight;
         }
         return _stageHeight;
      }
      
      override public function addPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = true, param4:Function = null) : DisplayObject
      {
         var _loc5_:* = null;
         Game.instance.screen.showDialogs();
         if(!(param1 is IModalPopup))
         {
            if(resourcePanel.panel.parent)
            {
               _root.removeChild(resourcePanel.panel);
            }
         }
         if(param2)
         {
            if(param4 == null)
            {
               param4 = this._overlayFactory;
            }
            if(param4 == null)
            {
               param4 = defaultOverlayFactory;
            }
            if(param1 is IModalPopup)
            {
               _loc5_ = param4();
            }
            else
            {
               if(modalPopupQueue.length)
               {
                  _root.removeChild(modalPopupQueue[modalPopupQueue.length - 1]);
               }
               modalPopupQueue.push(param1);
               if(this.overlay == null)
               {
                  this.overlay = param4();
               }
               _loc5_ = this.overlay;
            }
            _loc5_.width = stageWidth;
            _loc5_.height = stageHeight;
            this._root.addChild(_loc5_);
            this._popUpToOverlay[param1] = _loc5_;
         }
         this._popUps.push(param1);
         this._root.addChild(param1);
         param1.addEventListener("removedFromStage",popUp_removedFromStageHandler);
         if(this._popUps.length == 1)
         {
            if(_resizeEventDispatcher)
            {
               _resizeEventDispatcher.removeEventListener("resize",stage_resizeHandler);
            }
            if(this._root.stage)
            {
               _resizeEventDispatcher = this._root.stage;
            }
            _resizeEventDispatcher.addEventListener("resize",stage_resizeHandler);
         }
         if(param2 && FocusManager.isEnabledForStage(this._root.stage) && param1 is DisplayObjectContainer)
         {
            this._popUpToFocusManager[param1] = FocusManager.pushFocusManager(DisplayObjectContainer(param1));
         }
         if(param3)
         {
            if(param1 is IFeathersControl)
            {
               param1.addEventListener("resize",popUp_resizeHandler);
            }
            this._centeredPopUps.push(param1);
            this.centerPopUp(param1);
         }
         _signal_popupAdded.dispatch();
         var _loc6_:ClipBasedPopup = param1 as ClipBasedPopup;
         if(_loc6_ && _loc6_.popupMediator)
         {
            resourcePanel.setMediator(_loc6_ as ClipBasedPopup,_root);
         }
         if(param1 is ITutorialActionProvider)
         {
            Tutorial.addActionsFrom(param1 as ITutorialActionProvider);
         }
         if(param1 is ITutorialNodePresenter)
         {
            Tutorial.registerNode(param1 as ITutorialNodePresenter);
         }
         else
         {
            Tutorial.updateActions();
         }
         if(param1 is PopupBase)
         {
            stash_sendOpen(param1 as PopupBase);
         }
         ClickLoger.trigger_guiState();
         return param1;
      }
      
      override public function removePopUp(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:int = this._popUps.indexOf(param1);
         if(_loc3_ < 0)
         {
            if(param1 is PopupBase)
            {
               _popupQueue.unqueuePopup(param1 as PopupBase);
            }
            return null;
         }
         if(!(param1 is IModalPopup))
         {
            if(param1.parent && resourcePanel.panel.parent)
            {
               _root.removeChild(resourcePanel.panel);
            }
         }
         param1.removeFromParent(param2);
         handlePopupRemoved(param1);
         if(this._popUps.length == 0)
         {
            Game.instance.screen.hideDialogs();
         }
         _signal_popupRemoved.dispatch();
         return param1;
      }
      
      override public function centerPopUp(param1:DisplayObject) : void
      {
         if(param1 is IValidating)
         {
            IValidating(param1).validate();
         }
         param1.x = Math.round((stageWidth - param1.width) / 2);
         param1.y = Math.round((stageHeight - param1.height) / 2);
      }
      
      protected function handlePopupRemoved(param1:DisplayObject) : void
      {
         var _loc3_:* = null;
         param1.removeEventListener("removedFromStage",popUp_removedFromStageHandler);
         var _loc4_:int = this._popUps.indexOf(param1);
         this._popUps.splice(_loc4_,1);
         _loc4_ = modalPopupQueue.indexOf(param1);
         if(_loc4_ != -1)
         {
            if(_loc4_ == modalPopupQueue.length - 1)
            {
               modalPopupQueue.splice(_loc4_,1);
               if(modalPopupQueue.length > 0 && !(param1 is IModalPopup))
               {
                  readdPopup(modalPopupQueue[modalPopupQueue.length - 1]);
               }
            }
            else
            {
               modalPopupQueue.splice(_loc4_,1);
            }
         }
         if(param1 is ITutorialActionProvider)
         {
            Tutorial.removeActionsFrom(param1 as ITutorialActionProvider);
         }
         else
         {
            Tutorial.updateActions();
         }
         if(param1 is ITutorialNodePresenter)
         {
            Tutorial.unregister(param1 as ITutorialNodePresenter);
         }
         if(param1 is PopupBase)
         {
            stash_sendClose(param1 as PopupBase);
         }
         if(param1 is IModalPopup)
         {
            _loc3_ = DisplayObject(this._popUpToOverlay[param1]);
            if(_loc3_)
            {
               _loc3_.removeFromParent(true);
            }
         }
         if(modalPopupQueue.length == 0)
         {
            if(overlay)
            {
               overlay.removeFromParent(true);
               overlay = null;
            }
         }
         delete _popUpToOverlay[param1];
         var _loc2_:IFocusManager = this._popUpToFocusManager[param1] as IFocusManager;
         if(_loc2_)
         {
            delete this._popUpToFocusManager[param1];
            FocusManager.removeFocusManager(_loc2_);
         }
         _loc4_ = this._centeredPopUps.indexOf(param1);
         if(_loc4_ >= 0)
         {
            if(param1 is IFeathersControl)
            {
               param1.removeEventListener("resize",popUp_resizeHandler);
            }
            this._centeredPopUps.splice(_loc4_,1);
         }
         if(_popUps.length == 0)
         {
            if(_resizeEventDispatcher)
            {
               _resizeEventDispatcher.removeEventListener("resize",stage_resizeHandler);
            }
         }
      }
      
      protected function readdPopup(param1:DisplayObject) : void
      {
         _root.addChild(param1);
         var _loc2_:ClipBasedPopup = param1 as ClipBasedPopup;
         if(_loc2_ && _loc2_.popupMediator)
         {
            resourcePanel.setMediator(_loc2_,_root);
         }
         if(param1 is ITutorialNodePresenter)
         {
            Tutorial.registerNode(param1 as ITutorialNodePresenter);
         }
         else
         {
            Tutorial.updateActions();
         }
         if(param1 is ITutorialActionProvider)
         {
            Tutorial.updateActionsFrom(param1 as ITutorialActionProvider);
         }
      }
      
      override protected function popUp_removedFromStageHandler(param1:Event) : void
      {
      }
      
      override protected function stage_resizeHandler(param1:ResizeEvent) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Number = this.stageWidth;
         var _loc6_:Number = this.stageHeight;
         var _loc5_:int = this._popUps.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = this._popUps[_loc7_];
            _loc4_ = DisplayObject(this._popUpToOverlay[_loc3_]);
            if(_loc4_)
            {
               _loc4_.width = _loc2_;
               _loc4_.height = _loc6_;
            }
            _loc7_++;
         }
         _loc5_ = this._centeredPopUps.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = this._centeredPopUps[_loc7_];
            centerPopUp(_loc3_);
            _loc7_++;
         }
      }
      
      private function _tryCloseTopMost() : void
      {
         var _loc2_:int = _popUps.length;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc1_:PopupBase = _popUps[_loc2_ - 1] as PopupBase;
         if(_loc1_)
         {
            _loc1_.close();
         }
      }
      
      private function _closeAll() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Vector.<DisplayObject> = _popUps.slice();
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _loc3_[_loc4_] as ClipBasedPopup;
            if(_loc1_ && _loc1_.popupMediator)
            {
               _loc1_.popupMediator.close();
            }
            else
            {
               removePopUp(_loc3_[_loc4_],true);
            }
            _loc4_++;
         }
      }
      
      private function popupOverlay() : DisplayObject
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(AssetStorage.rsx.popup_theme.data.getClipByName("popup_overlay"))
         {
            _loc3_ = AssetStorage.rsx.popup_theme.create(PopupOverlay,"popup_overlay");
            _loc3_.tweenShow();
            return _loc3_.graphics;
         }
         if(AssetStorage.rsx.popup_theme.data.getClipByName("city_bg"))
         {
            _loc1_ = new Image(AssetStorage.rsx.popup_theme.getTexture("city_bg"));
            return _loc1_;
         }
         _loc2_ = new Quad(10,10,0);
         _loc2_.alpha = 0.5;
         return _loc2_;
      }
      
      protected function stash_sendOpen(param1:PopupBase) : void
      {
         var _loc2_:* = null;
         if(param1 && param1.stashParams)
         {
            _loc2_ = param1.stashParams;
            if(param1.stashSourceClick)
            {
               _loc2_.prevWindowName = param1.stashSourceClick.windowName;
               _loc2_.prevActionName = param1.stashSourceClick.actionType;
               _loc2_.prevButtonName = param1.stashSourceClick.buttonName;
            }
            if(_loc2_.windowName)
            {
               GameModel.instance.actionManager.stashEvent(new StashEventDescription(".client.window.open",_loc2_));
            }
         }
      }
      
      protected function stash_sendClose(param1:PopupBase) : void
      {
         var _loc2_:* = null;
         if(param1 && param1.stashParams)
         {
            _loc2_ = param1.stashParams;
            if(_loc2_.windowName)
            {
               GameModel.instance.actionManager.stashEvent(new StashEventDescription(".client.window.close",_loc2_));
            }
         }
      }
   }
}
