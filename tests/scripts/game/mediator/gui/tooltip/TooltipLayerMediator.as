package game.mediator.gui.tooltip
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.display.Stage;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class TooltipLayerMediator
   {
      
      private static var _instance:TooltipLayerMediator;
       
      
      private var _floatingHints:Dictionary;
      
      private var _nodesByGraphics:Dictionary;
      
      private var _nodesByView:Dictionary;
      
      private var _hintPool:Dictionary;
      
      private var _validationTimeout:int;
      
      private var _rootNode:TooltipNode;
      
      private var _tooltipLayer:DisplayObjectContainer;
      
      private var _mousePosition:Point;
      
      public function TooltipLayerMediator()
      {
         _mousePosition = new Point();
         super();
         _nodesByView = new Dictionary();
         _nodesByGraphics = new Dictionary();
         _floatingHints = new Dictionary();
         _hintPool = new Dictionary();
         _tooltipLayer = new Sprite();
         _instance = this;
      }
      
      public static function get instance() : TooltipLayerMediator
      {
         return _instance;
      }
      
      public static function calcPosition(param1:DisplayObject, param2:DisplayObject) : Point
      {
         var _loc4_:* = 0;
         _loc4_ = uint(10);
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Point = TooltipLayerMediator.instance.mousePosition;
         var _loc3_:Point = new Point(_loc7_.x + 5,_loc7_.y + 5);
         if(_loc3_.x + param1.width + 10 > param2.stage.stageWidth)
         {
            _loc5_ = _loc3_.x - 10 - param1.width;
         }
         else
         {
            _loc5_ = _loc3_.x + 10;
         }
         if(_loc3_.y + param1.height + 10 > param2.stage.stageHeight)
         {
            _loc6_ = _loc3_.y - 10 - param1.height;
         }
         else
         {
            _loc6_ = _loc3_.y + 10;
         }
         _loc3_.x = _loc5_;
         _loc3_.y = _loc6_;
         return _loc3_;
      }
      
      public static function calcPositionInScreen(param1:DisplayObject, param2:DisplayObject) : Point
      {
         var _loc4_:* = 0;
         _loc4_ = uint(10);
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Point = TooltipLayerMediator.instance.mousePosition;
         var _loc3_:Point = new Point(_loc7_.x + 5,_loc7_.y + 5);
         if(_loc3_.x + param1.width + 10 > param2.stage.stageWidth)
         {
            _loc5_ = _loc3_.x - 10 - param1.width;
         }
         else
         {
            _loc5_ = _loc3_.x + 10;
         }
         var _loc9_:Number = _loc3_.y + param1.height + 10 - param2.stage.stageHeight;
         var _loc8_:Number = _loc3_.y - 10 - param1.height;
         if(_loc9_ < 0)
         {
            _loc6_ = _loc3_.y + 10;
         }
         else if(-_loc8_ < 0)
         {
            _loc6_ = _loc3_.y - 10 - param1.height;
         }
         else if(_loc9_ > -_loc8_)
         {
            _loc6_ = _loc3_.y - 10 - param1.height - _loc8_;
         }
         else
         {
            _loc6_ = _loc3_.y + 10 - _loc9_;
         }
         _loc3_.x = _loc5_;
         _loc3_.y = _loc6_;
         return _loc3_;
      }
      
      public function get tooltipLayer() : DisplayObjectContainer
      {
         return _tooltipLayer;
      }
      
      public function get mousePosition() : Point
      {
         return _mousePosition;
      }
      
      public function addSource(param1:ITooltipSource) : void
      {
         var _loc2_:* = null;
         var _loc3_:TooltipNode = new TooltipNode();
         _loc3_.source = param1;
         _nodesByGraphics[param1.graphics] = _loc3_;
         if(param1.graphics)
         {
            _loc2_ = findSourceParent(param1.graphics);
            _loc3_.parent = _loc2_;
            _loc2_.children[_loc3_] = _loc3_;
            attachSourceHandlers(param1.graphics);
         }
      }
      
      public function removeSource(param1:ITooltipSource) : void
      {
         var _loc3_:TooltipNode = _nodesByGraphics[param1.graphics] as TooltipNode;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.view)
         {
            hideHint(_loc3_);
         }
         var _loc2_:TooltipNode = _loc3_.parent as TooltipNode;
         delete _loc2_.children[_loc3_];
         if(param1.graphics)
         {
            detachSourceHandlers(param1.graphics);
         }
         _loc3_.parent = null;
         _loc3_.source = null;
         return;
         §§push(delete _nodesByGraphics[param1.graphics]);
      }
      
      public function init() : void
      {
         var _loc1_:Stage = _tooltipLayer.stage;
         _loc1_.addEventListener("TooltipEventType.SOURCE_ADDED",handler_sourceAdded);
         _loc1_.addEventListener("TooltipEventType.SOURCE_REMOVED",handler_sourceRemoved);
         _loc1_.addEventListener("TooltipEventType.SOURCE_UPDATED",handler_sourceUpdated);
         _loc1_.addEventListener("touch",handler_updateMousePosition);
         _rootNode = new TooltipNode();
         _nodesByGraphics[_loc1_] = _rootNode;
         _rootNode.viewOvered = true;
      }
      
      public function add(param1:ITooltipSource, param2:TooltipTextView) : void
      {
         var _loc3_:* = null;
         var _loc4_:TooltipNode = new TooltipNode();
         _loc4_.source = param1;
         _nodesByGraphics[param1.graphics] = _loc4_;
         if(param1.graphics)
         {
            _loc3_ = findSourceParent(param1.graphics);
            _loc4_.parent = _loc3_;
            _loc3_.children[_loc4_] = _loc4_;
            attachSourceHandlers(param1.graphics);
         }
      }
      
      private function attachSourceHandlers(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = param1 as Object;
         if(_loc3_.hasOwnProperty("useCustomHintHandlers") && _loc3_.useCustomHintHandlers == true)
         {
            _loc2_ = 1;
         }
         else
         {
            param1.addEventListener("touch",handler_sourceTouch);
         }
         param1.addEventListener("TooltipEventType.SOURCE_OVERED",handler_sourceOvered);
         param1.addEventListener("TooltipEventType.SOURCE_OUTED",handler_sourceOuted);
         param1.addEventListener("removedFromStage",handler_sourceRemovedFromStage);
      }
      
      private function detachSourceHandlers(param1:EventDispatcher) : void
      {
         param1.removeEventListener("touch",handler_sourceTouch);
         param1.removeEventListener("TooltipEventType.SOURCE_OVERED",handler_sourceOvered);
         param1.removeEventListener("TooltipEventType.SOURCE_OUTED",handler_sourceOuted);
         param1.removeEventListener("removedFromStage",handler_sourceRemovedFromStage);
      }
      
      private function attachViewHandlers(param1:EventDispatcher) : void
      {
         param1.addEventListener("touch",handler_viewTouch);
      }
      
      private function detachViewHandlers(param1:EventDispatcher) : void
      {
         param1.removeEventListener("touch",handler_viewTouch);
      }
      
      private function hideHint(param1:TooltipNode) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(param1.view)
         {
            _loc3_ = param1.view as ITooltipView;
            _loc4_ = getDefinitionByName(getQualifiedClassName(param1.view)) as Class;
            if(!(_loc4_ in _hintPool))
            {
               _hintPool[_loc4_] = [];
            }
            _loc2_ = _hintPool[_loc4_];
            _loc3_.hide();
            detachViewHandlers(_loc3_ as EventDispatcher);
            if(_loc3_ in _floatingHints)
            {
               delete _floatingHints[_loc3_];
            }
            _loc2_.push(_loc3_);
            delete _nodesByView[_loc3_];
            param1.view = null;
         }
      }
      
      private function showHint(param1:TooltipNode) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:TooltipVO = param1.source.tooltipVO;
         if(!param1.view && _loc5_)
         {
            _loc4_ = _loc5_.hintClass;
            _loc2_ = _hintPool[_loc4_];
            if(_loc2_ && _loc2_.length)
            {
               _loc3_ = _loc2_.pop();
            }
            else
            {
               _loc3_ = new _loc4_() as ITooltipView;
            }
            param1.view = _loc3_;
            _nodesByView[_loc3_] = param1;
            if(_loc5_.behavior == "TooltipVO.HINT_BEHAVIOR_STATIC_INTERACTIVE")
            {
               attachViewHandlers(_loc3_ as EventDispatcher);
            }
            else if(_loc5_.behavior == "TooltipVO.HINT_BEHAVIOR_MOVING")
            {
               _floatingHints[_loc3_] = _loc3_;
            }
            _loc3_.show(param1.source,_tooltipLayer);
            _loc3_.placeHint(param1.source,_tooltipLayer);
         }
      }
      
      public function hideAll(... rest) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _nodesByView;
         for each(var _loc2_ in _nodesByView)
         {
            if(_loc2_)
            {
               hideHint(_loc2_);
            }
         }
      }
      
      private function validate(param1:TooltipNode = null) : void
      {
         clearInterval(_validationTimeout);
         var _loc2_:Boolean = false;
         if(!param1)
         {
            param1 = _rootNode;
            _loc2_ = true;
         }
         var _loc5_:int = 0;
         var _loc4_:* = param1.children;
         for each(var _loc3_ in param1.children)
         {
            validateNode(_loc3_);
            validate(_loc3_);
         }
      }
      
      private function validateNode(param1:TooltipNode) : void
      {
         clearInterval(_validationTimeout);
         if(!param1.branchOvered && param1.view)
         {
            hideHint(param1);
         }
         else if(param1.branchOvered && !param1.view)
         {
            showHint(param1);
         }
      }
      
      private function invalidate(param1:int) : void
      {
         if(param1)
         {
            _validationTimeout = setTimeout(validate,param1);
         }
         else
         {
            validate();
         }
      }
      
      private function invalidateNode(param1:int, param2:TooltipNode) : void
      {
         if(param1)
         {
            _validationTimeout = setTimeout(validateNode,param1,param2);
         }
         else
         {
            validateNode(param2);
         }
      }
      
      private function findSourceParent(param1:DisplayObject) : TooltipNode
      {
         var _loc2_:DisplayObject = param1.parent;
         while(!_nodesByGraphics[_loc2_])
         {
            _loc2_ = _loc2_.parent;
         }
         if(_nodesByGraphics[_loc2_])
         {
            return _nodesByGraphics[_loc2_] as TooltipNode;
         }
         throw "wtf?";
      }
      
      private function handler_updateMousePosition(param1:TouchEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:Touch = param1.getTouch(_tooltipLayer.stage);
         if(_loc2_)
         {
            _tooltipLayer.globalToLocal(new Point(_loc2_.globalX,_loc2_.globalY),_mousePosition);
            var _loc6_:int = 0;
            var _loc5_:* = _floatingHints;
            for each(var _loc3_ in _floatingHints)
            {
               _loc4_ = _nodesByView[_loc3_].source;
               _loc3_.placeSelf(_loc4_,_tooltipLayer);
            }
         }
      }
      
      private function handler_sourceOvered(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         if(!_loc2_)
         {
            throw "null hint source";
         }
         var _loc4_:TooltipNode = _nodesByGraphics[_loc2_] as TooltipNode;
         _loc4_.sourceOvered = true;
         var _loc3_:TooltipVO = _loc4_.source.tooltipVO;
         if(_loc3_)
         {
            invalidate(_loc3_.showTimeout);
         }
      }
      
      private function handler_sourceOuted(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         var _loc4_:TooltipNode = _nodesByGraphics[_loc2_] as TooltipNode;
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.sourceOvered)
         {
            _loc4_.sourceOvered = false;
            _loc3_ = _loc4_.source.tooltipVO;
            if(_loc3_)
            {
               invalidate(_loc3_.hideTimeout);
            }
         }
      }
      
      private function handler_sourceTouch(param1:TouchEvent) : void
      {
         if(param1.getTouch(param1.currentTarget as DisplayObject,"hover"))
         {
            handler_sourceOvered(param1);
         }
         else
         {
            handler_sourceOuted(param1);
         }
      }
      
      private function handler_viewTouch(param1:TouchEvent) : void
      {
         if(param1.getTouch(param1.currentTarget as DisplayObject,"hover"))
         {
            handler_viewOvered(param1);
         }
         else
         {
            handler_viewOuted(param1);
         }
      }
      
      private function handler_sourceRemovedFromStage(param1:Event) : void
      {
         handler_sourceOuted(param1);
      }
      
      private function handler_viewOvered(param1:Event) : void
      {
         var _loc2_:ITooltipView = param1.currentTarget as ITooltipView;
         var _loc3_:TooltipNode = _nodesByView[_loc2_] as TooltipNode;
         _loc3_.viewOvered = true;
      }
      
      private function handler_viewOuted(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:ITooltipView = param1.currentTarget as ITooltipView;
         var _loc4_:TooltipNode = _nodesByView[_loc2_] as TooltipNode;
         if(_loc4_.viewOvered)
         {
            _loc4_.viewOvered = false;
            _loc3_ = _loc4_.source.tooltipVO;
            invalidate(_loc3_.hideTimeout);
         }
      }
      
      private function handler_sourceAdded(param1:Event) : void
      {
         if(param1.target is ITooltipSource)
         {
            addSource(param1.target as ITooltipSource);
         }
         else if(param1.data is ITooltipSource)
         {
            addSource(param1.data as ITooltipSource);
         }
      }
      
      private function handler_sourceUpdated(param1:Event) : void
      {
         var _loc2_:ITooltipSource = param1.target as ITooltipSource;
         var _loc3_:TooltipNode = _nodesByGraphics[_loc2_.graphics] as TooltipNode;
         if(_loc2_ && _loc3_ && _loc3_.view)
         {
            hideHint(_loc3_);
            showHint(_loc3_);
            validate();
         }
      }
      
      private function handler_sourceRemoved(param1:Event) : void
      {
         if(param1.target is ITooltipSource)
         {
            removeSource(param1.target as ITooltipSource);
         }
         else if(param1.data is ITooltipSource)
         {
            removeSource(param1.data as ITooltipSource);
         }
      }
   }
}
