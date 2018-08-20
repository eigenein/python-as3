package com.progrestar.common.social.datavalue
{
   import org.osflash.signals.Signal;
   
   public class SocialPaymentBox
   {
       
      
      public var socialMoney:int;
      
      public var title:String;
      
      public var message:String;
      
      public var code:String;
      
      public var params:Object;
      
      public var fb_productURL:String;
      
      public var fb_productPricepointId:String;
      
      public var type:String;
      
      private var _signal_onSuccess:Signal;
      
      private var _signal_onPendingRequested:Signal;
      
      private var _signal_onError:Signal;
      
      private var _signal_onRefuse:Signal;
      
      private var wasSuccessfull:Boolean;
      
      public function SocialPaymentBox(param1:int, param2:String = null, param3:String = null, param4:String = null, param5:Object = null)
      {
         super();
         this.socialMoney = param1;
         this.title = param2;
         this.message = param3;
         this.code = param4;
         this.params = param5;
      }
      
      public function dispose() : void
      {
         if(_signal_onSuccess)
         {
            _signal_onSuccess.removeAll();
         }
         if(_signal_onError)
         {
            _signal_onError.removeAll();
         }
         if(_signal_onRefuse)
         {
            _signal_onRefuse.removeAll();
         }
      }
      
      public function get signal_onSuccess() : Signal
      {
         if(!_signal_onSuccess)
         {
            _signal_onSuccess = new Signal();
         }
         return _signal_onSuccess;
      }
      
      public function get signal_onPendingRequested() : Signal
      {
         if(!_signal_onPendingRequested)
         {
            _signal_onPendingRequested = new Signal(Number);
         }
         return _signal_onPendingRequested;
      }
      
      public function get signal_onError() : Signal
      {
         if(!_signal_onError)
         {
            _signal_onError = new Signal();
         }
         return _signal_onError;
      }
      
      public function get signal_onRefuse() : Signal
      {
         if(!_signal_onRefuse)
         {
            _signal_onRefuse = new Signal();
         }
         return _signal_onRefuse;
      }
      
      public function onSuccess() : void
      {
         wasSuccessfull = true;
         if(_signal_onSuccess)
         {
            _signal_onSuccess.dispatch();
         }
      }
      
      public function requestPending(param1:Number) : void
      {
         wasSuccessfull = true;
         if(_signal_onPendingRequested)
         {
            _signal_onPendingRequested.dispatch(param1);
         }
      }
      
      public function onError() : void
      {
         if(_signal_onError && !wasSuccessfull)
         {
            _signal_onError.dispatch();
         }
      }
      
      public function onRefuse() : void
      {
         if(_signal_onRefuse && !wasSuccessfull)
         {
            _signal_onRefuse.dispatch();
         }
      }
   }
}
