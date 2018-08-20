package feathers.skins
{
   import flash.utils.Dictionary;
   
   public class StyleProviderRegistry
   {
      
      protected static const GLOBAL_STYLE_PROVIDER_PROPERTY_NAME:String = "globalStyleProvider";
       
      
      protected var _registerGlobally:Boolean;
      
      protected var _styleProviderFactory:Function;
      
      protected var _classToStyleProvider:Dictionary;
      
      public function StyleProviderRegistry(param1:Boolean = true, param2:Function = null)
      {
         _classToStyleProvider = new Dictionary(true);
         super();
         this._registerGlobally = param1;
         if(param2 === null)
         {
            this._styleProviderFactory = defaultStyleProviderFactory;
         }
         else
         {
            this._styleProviderFactory = param2;
         }
      }
      
      protected static function defaultStyleProviderFactory() : IStyleProvider
      {
         return new StyleNameFunctionStyleProvider();
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = this._classToStyleProvider;
         for(var _loc1_ in this._classToStyleProvider)
         {
            _loc2_ = Class(_loc1_);
            this.clearStyleProvider(_loc2_);
         }
         this._classToStyleProvider = null;
      }
      
      public function getStyleProvider(param1:Class) : IStyleProvider
      {
         this.validateComponentClass(param1);
         var _loc2_:IStyleProvider = IStyleProvider(this._classToStyleProvider[param1]);
         if(!_loc2_)
         {
            _loc2_ = this._styleProviderFactory();
            this._classToStyleProvider[param1] = _loc2_;
            if(this._registerGlobally)
            {
               param1["globalStyleProvider"] = _loc2_;
            }
         }
         return _loc2_;
      }
      
      public function clearStyleProvider(param1:Class) : void
      {
         var _loc2_:* = null;
         this.validateComponentClass(param1);
         if(param1 in this._classToStyleProvider)
         {
            _loc2_ = IStyleProvider(this._classToStyleProvider[param1]);
            delete this._classToStyleProvider[param1];
            if(this._registerGlobally && param1["globalStyleProvider"] === _loc2_)
            {
               param1["globalStyleProvider"] = null;
            }
         }
      }
      
      protected function validateComponentClass(param1:Class) : void
      {
         if(!this._registerGlobally || Object(param1).hasOwnProperty("globalStyleProvider"))
         {
            return;
         }
         throw ArgumentError("Class " + param1 + " must have a " + "globalStyleProvider" + " static property to support themes.");
      }
   }
}
