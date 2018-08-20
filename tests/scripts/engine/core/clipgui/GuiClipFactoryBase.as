package engine.core.clipgui
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.PropertyMapManager;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.extension.Scale9DataExtension;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import starling.display.DisplayObjectContainer;
   
   public class GuiClipFactoryBase
   {
      
      private static var GuiClipObjectPrototype = GuiClipObject.prototype;
      
      private static var IGuiClipString:String = getQualifiedClassName(IGuiClip);
      
      private static var IClipLayoutString:String = getQualifiedClassName(IClipLayout);
      
      private static var VectorBaseString:String = getQualifiedClassName(Vector.<*>);
      
      private static var InvalidType = true;
      
      private static var childrenStack:Vector.<IGuiClip> = new Vector.<IGuiClip>();
      
      private static var childrenCount:int = 0;
      
      private static var defaultNode:Node = new Node(-1);
      
      {
         defaultNode.state = new State();
         defaultNode.state.matrix = new Matrix();
      }
      
      protected var _createUnimplementedChildren:Boolean = true;
      
      protected var _verbose:Boolean = false;
      
      public function GuiClipFactoryBase()
      {
         super();
      }
      
      public static function getScale9Grid(param1:Clip) : Rectangle
      {
         if(param1.timeLine.length != 1 || !(param1.timeLine[0] is Frame))
         {
            return null;
         }
         var _loc3_:ClipAsset = (param1.timeLine[0] as Frame).image.resource;
         var _loc2_:Scale9DataExtension = Scale9DataExtension.fromAsset(_loc3_);
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.getGridByClip(param1);
      }
      
      public function create(param1:IGuiClip, param2:Clip) : void
      {
         assert(param2);
         var _loc3_:* = getDefinitionByName(getQualifiedClassName(param1));
         if(param1 is INeedNestedParsing)
         {
            extractClipContentByProperties(param1 as INeedNestedParsing,param2,_loc3_);
         }
         defaultNode.clip = param2;
         param1.setNode(defaultNode);
      }
      
      public function createByNode(param1:IGuiClip, param2:Node) : void
      {
         assert(param2.clip);
         var _loc3_:* = getDefinitionByName(getQualifiedClassName(param1));
         if(param1 is INeedNestedParsing)
         {
            extractClipContentByProperties(param1 as INeedNestedParsing,param2.clip,_loc3_);
         }
         defaultNode.clip = param2.clip;
         param1.setNode(param2);
      }
      
      protected function extractClipContentByProperties(param1:INeedNestedParsing, param2:Clip, param3:Class) : void
      {
         var _loc8_:* = 0;
         var _loc11_:* = null;
         var _loc19_:* = null;
         var _loc15_:* = null;
         var _loc9_:* = null;
         var _loc14_:int = 0;
         var _loc18_:int = 0;
         var _loc10_:* = undefined;
         var _loc17_:* = undefined;
         if(!(param2.timeLine[0] is Container))
         {
            trace(getQualifiedClassName(this),"extractClipContentByProperties:",getQualifiedClassName(param1)," реализует интерфейс INeedNestedParsing, но клип " + param2.className + " не является контейнером, который можно обработать");
            assert(false);
            return;
         }
         if(param2.timeLine.length > 1 && !(param1 is IGuiAnimatedContainer))
         {
            trace(getQualifiedClassName(this),"extractClipContentByProperties:",getQualifiedClassName(param1)," реализует интерфейс INeedNestedParsing, но не IGuiAnimatedContainer но клип " + param2.className + " является анимацией");
            assert(false);
            return;
         }
         var _loc16_:Dictionary = PropertyMapManager.getTypeMap(param3,true);
         var _loc4_:DisplayObjectContainer = param1.container;
         var _loc12_:Vector.<Node> = (param2.timeLine[0] as Container).nodes;
         var _loc7_:int = _loc12_.length;
         var _loc6_:Dictionary = new Dictionary();
         var _loc13_:Vector.<IGuiClip> = childrenStack;
         var _loc5_:int = childrenCount;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc11_ = _loc12_[_loc8_];
            _loc19_ = null;
            _loc15_ = _loc11_.state.name;
            _loc9_ = _loc16_[_loc15_];
            _loc14_ = _loc15_.indexOf("$");
            if(_loc14_ != -1)
            {
               _loc18_ = _loc15_.substr(_loc14_ + 1);
               _loc15_ = _loc15_.substr(0,_loc14_);
               _loc9_ = _loc16_[_loc15_];
               if(_loc9_ != null)
               {
                  _loc10_ = getVectorChildType(_loc15_,_loc6_,_loc9_);
                  if(_loc10_ != InvalidType)
                  {
                     if(param1[_loc15_])
                     {
                        §§push(param1[_loc15_]);
                     }
                     else
                     {
                        var _loc20_:* = new _loc9_();
                        param1[_loc15_] = _loc20_;
                        §§push(_loc20_);
                     }
                     _loc17_ = §§pop();
                     if(_loc18_ >= _loc17_.length)
                     {
                        _loc17_.length = _loc18_;
                     }
                     _loc20_ = new _loc10_();
                     _loc17_[_loc18_] = _loc20_;
                     _loc19_ = _loc20_;
                     addr274:
                     if(_loc19_)
                     {
                        _loc13_[childrenCount] = _loc19_;
                        childrenCount = Number(childrenCount) + 1;
                        applyChildNode(_loc4_,_loc19_,_loc11_,_loc10_);
                     }
                  }
               }
            }
            else if(_loc9_ == null)
            {
               unimplementedChild(param1,_loc4_,_loc15_,_loc11_);
            }
            else
            {
               _loc10_ = _loc9_;
               if(param1[_loc15_])
               {
                  if(param1[_loc15_] is IGuiClip)
                  {
                     _loc19_ = param1[_loc15_];
                     _loc10_ = getDefinitionByName(getQualifiedClassName(_loc19_));
                  }
                  §§goto(addr274);
               }
               else if(PropertyMapManager.implementsInterface(_loc9_,IGuiClipString))
               {
                  _loc20_ = new _loc9_();
                  param1[_loc15_] = _loc20_;
                  _loc19_ = _loc20_;
                  §§goto(addr274);
               }
               else
               {
                  wrongTypeVariable(param1,_loc11_,_loc9_);
               }
            }
            _loc8_++;
         }
         _loc8_ = _loc5_;
         while(_loc8_ < childrenCount)
         {
            if(_loc13_[_loc8_] is IClipLayout)
            {
               (_loc13_[_loc8_] as IClipLayout).layoutChildren();
            }
            _loc8_++;
         }
         childrenCount = _loc5_;
         childrenStack.length = _loc5_;
      }
      
      protected function applyChildNode(param1:DisplayObjectContainer, param2:IGuiClip, param3:Node, param4:*) : void
      {
         if(param2 is INeedNestedParsing && !param3.clip.marker)
         {
            extractClipContentByProperties(param2 as INeedNestedParsing,param3.clip,param4);
         }
         param2.setNode(param3);
         if(param2.graphics)
         {
            param2.graphics.name = param3.state.name;
            param1.addChild(param2.graphics);
         }
      }
      
      protected function getVectorChildType(param1:String, param2:Dictionary, param3:Class) : *
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = undefined;
         if(!param2[param1])
         {
            _loc5_ = getQualifiedClassName(param3);
            _loc6_ = _loc5_.substring(_loc5_.indexOf("<") + 1,_loc5_.lastIndexOf(">"));
            _loc4_ = getDefinitionByName(_loc6_);
            if(PropertyMapManager.implementsInterface(_loc4_,IGuiClipString))
            {
               var _loc7_:* = _loc4_;
               param2[param1] = _loc7_;
               return _loc7_;
            }
            _loc7_ = InvalidType;
            param2[param1] = _loc7_;
            return _loc7_;
         }
         return param2[param1];
      }
      
      protected function unimplementedChild(param1:*, param2:DisplayObjectContainer, param3:String, param4:Node) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(_createUnimplementedChildren)
         {
            _loc5_ = getScale9Grid(param4.clip);
            if(_loc5_)
            {
               if(_verbose)
               {
                  trace(this + ": Автоматически создан scale9 " + param3 + " of " + param4.clip.className);
               }
               if(_loc5_.height == 0)
               {
                  _loc6_ = new GuiClipScale3Image(_loc5_.x,_loc5_.width);
               }
               else if(_loc5_.width == 0)
               {
                  _loc6_ = new GuiClipScale3Image(_loc5_.y,_loc5_.height,"vertical");
               }
               else
               {
                  _loc6_ = new GuiClipScale9Image(_loc5_);
               }
            }
            else if(param4.clip.timeLine.length > 1)
            {
               if(_verbose)
               {
                  trace(this + ": Автоматически создана анимация " + param3 + " of " + param4.clip.className);
               }
               _loc6_ = new GuiAnimation();
            }
            else
            {
               if(_verbose)
               {
                  trace(this + ": Автоматически создан " + param3 + " of " + param4.clip.className);
               }
               _loc6_ = new ClipSprite();
            }
            return applyChildNode(param2,_loc6_,param4,null);
         }
         childNotImplemented(param1,param4);
      }
      
      protected function wrongTypeVariable(param1:IGuiClip, param2:Node, param3:Class) : void
      {
         if(_verbose)
         {
            trace(this + ": Неверный тип переменной, ожидался IGuiClip, получен ",param3);
         }
      }
      
      protected function childNotImplemented(param1:INeedNestedParsing, param2:Node) : void
      {
         if(_verbose)
         {
            trace(this + ": Нет переменной для клипа",param2.state.name);
         }
      }
      
      private function _sortNodes(param1:Node, param2:Node) : Number
      {
         return (param1 is IClipLayout?1:0) - (param2 is IClipLayout?1:0);
      }
   }
}
