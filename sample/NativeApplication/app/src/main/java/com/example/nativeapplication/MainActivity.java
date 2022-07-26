package com.example.nativeapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.example.nativeapplication.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'nativeapplication' library on application startup.
    static {
        System.loadLibrary("nativeapplication");
    }

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Example of a call to a native method
        TextView tv = binding.sampleText;
        tv.setText(stringFromJNI());
    }

    /**
     * A native method that is implemented by the 'nativeapplication' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
}